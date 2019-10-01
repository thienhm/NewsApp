//
//  RestApi.swift
//  Link Up
//
//  Created by BJ Low on 6/5/16.
//  Copyright © 2016 Ozzie Tech Private Limited. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum RestApi: URLRequestConvertible {
    
    static let ENDPOINT = "https://newsapi.org/v2"
    static let APIKEY = ""
    
    case getTopHeadlines(pageSize: Int, page: Int)
    

    func asURLRequest() throws -> URLRequest {
        
        let restApiRequest: RestApiRequest = {
            
            switch self {
                
            case .getTopHeadlines(let pageSize, let page):
                
                return RestApiRequest(
                    method: .get,
                    path: "/top-headlines",
                    headerMap: nil,
                    queryMap: ["country": "us", "apiKey": RestApi.APIKEY, "pageSize": pageSize, "page": page],
                    fieldMap: nil,
                    body: nil)
            
            
            }
        }()
        
        return try restApiRequest.getURLRequest(with: RestApi.ENDPOINT)
    }
}
