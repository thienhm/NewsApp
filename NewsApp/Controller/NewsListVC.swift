//
//  NewsListVC.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class NewsListVC: UITableViewController {

    private var pageIndex = 1
    private let pageSize = 20
    private var canLoadMore = true
    
    var category: NewsCategory?
    
    private var newsList: [News] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - VC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category != nil ? "Custom News" : "Top Headline"
        
        getNews(at: pageIndex, pageSize: pageSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewsDetail",
            let selectedIndex = tableView.indexPathForSelectedRow,
            let newsDetailVC = segue.destination as? NewsDetailVC {
            
            newsDetailVC.news = newsList[selectedIndex.row]
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cell.imgUrlString = newsList[indexPath.row].urlToImage
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        // if will display last row
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            willDisplayLastRow()
        }
    }
    
    // MARK: - Func
    
    private func getNews(at pageIndex: Int, pageSize: Int) {
        
        let api: RestApi = category != nil ? .getCustomNews(category: category!.rawValue, pageSize: pageSize, page: pageIndex) : .getTopHeadlines(pageSize: pageSize, page: pageIndex)
        
        ApiAlamofire.shared.request(api).responseObject { [weak self] (response: DataResponse<NewsResponse>) in
            
            switch response.result {
                
            case .success(let data):
                
                // guard has response
                guard !data.articles.isEmpty else {
                    self?.canLoadMore = false
                    return
                }
                
                // append to current news list
                self?.newsList += data.articles
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func willDisplayLastRow() {
        
        // guard can load more
        guard canLoadMore else {
            return
        }
        
        pageIndex += 1
        getNews(at: pageIndex, pageSize: pageSize)
    }
    
}
