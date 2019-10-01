//
//  CategoryVC.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/2/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class {
    func categoryVC(didSelectCategory: String)
}

class CategoryVC: UITableViewController {

    weak var delegate: CategoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return NewsCategory.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        cell.textLabel?.text = NewsCategory.all[indexPath.row].string
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cate = NewsCategory.all[indexPath.row].string
        delegate?.categoryVC(didSelectCategory: cate)
        
        navigationController?.popViewController(animated: true)
    }

}
