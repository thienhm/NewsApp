//
//  User.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    private(set) var name = ""
    private(set) var password = ""
    private(set) var category = ""
    
    var newsCategory: NewsCategory? {
        return NewsCategory(rawValue: category)
    }
    
    init?(map: Map) {}
    
    init(name: String, password: String, category: NewsCategory) {
        
        self.name = name
        self.password = password
        self.category = category.rawValue
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        password <- map["password"]
        category <- map["category"]
    }
}
