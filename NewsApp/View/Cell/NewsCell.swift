//
//  NewsCell.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!

    var imgUrlString: String? {
        didSet {
            guard let imgUrlString = imgUrlString, let imgUrl = URL(string: imgUrlString) else {
                img.image = nil
                return
            }
            
            img.sd_setImage(with: imgUrl)
        }
    }
    
}
