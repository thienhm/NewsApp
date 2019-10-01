//
//  Category.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Foundation

enum NewsCategory: String {
    
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    static let all: [NewsCategory] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
    
    var string: String {
        return self.rawValue.capitalized
    }
}
