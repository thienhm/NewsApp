//
//  RestApi.swift
//  Link Up
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum RestApi: URLRequestConvertible {
    
    static let ENDPOINT = "https://newsapi.org/v2"
    static let APIKEY = "2069603d0f78447f9b67977b97b1eba1"
    
    case getTopHeadlines(pageSize: Int, page: Int)
    case getCustomNews(category: String, pageSize: Int, page: Int)
    

    func asURLRequest() throws -> URLRequest {
        
        let restApiRequest: RestApiRequest = {
            
            switch self {
                
            case .getTopHeadlines(let pageSize, let page):
                
                return RestApiRequest(
                    method: .get,
                    path: "/top-headlines",
                    headerMap: nil,
                    queryMap: ["country": "us", "pageSize": pageSize, "page": page, "apiKey": RestApi.APIKEY],
                    fieldMap: nil,
                    body: nil)
            
            case .getCustomNews(let category, let pageSize, let page):
                
                return RestApiRequest(
                    method: .get,
                    path: "/top-headlines",
                    headerMap: nil,
                    queryMap: ["category": category, "pageSize": pageSize, "page": page, "apiKey": RestApi.APIKEY],
                    fieldMap: nil,
                    body: nil)
            
            }
        }()
        
        return try restApiRequest.getURLRequest(with: RestApi.ENDPOINT)
    }
}
