//
//  News.swift
//  NewsApp
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Foundation
import ObjectMapper

struct News: Mappable {
    
    private(set) var urlToImage: String?
    private(set) var url: String?
    private(set) var title: String?
    private(set) var description: String?
    private(set) var author: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        urlToImage <- map["urlToImage"]
        url <- map["url"]
        title <- map["title"]
        description <- map["description"]
        author <- map["author"]
    }
}

struct NewsResponse: Mappable {
    
    private(set) var articles: [News] = []
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        articles <- map["articles"]
    }
}
