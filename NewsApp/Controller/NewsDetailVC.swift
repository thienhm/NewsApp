//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetailVC: UIViewController {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateNews()
    }
    
    func updateNews() {
        
        newsTitle.text = news.title
        if let urlToImage = news.urlToImage, let imgUrl = URL(string: urlToImage) {
            img.sd_setImage(with: imgUrl)
        }
    }
    
    @IBAction func openOriginal(sender: UIButton) {
        
        // if can open url
        if let newsUrlString = news.url,
            let newsUrl = URL(string: newsUrlString),
            UIApplication.shared.canOpenURL(newsUrl) {
            
            // open news url
            UIApplication.shared.open(newsUrl)
        }
    }
    
}
