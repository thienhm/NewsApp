//
//  RestApiRequest.swift
//  Link Up
//
//  Created by BJ Low on 21/6/16.
//  Copyright © 2016 Ozzie Tech Private Limited. All rights reserved.
//

import Foundation
import Alamofire

class RestApiRequest {
	
	private(set) var method: HTTPMethod
	private(set) var path: String?
	private(set) var headerMap: [String: String]?
	private(set) var queryMap: [String: Any]?
	private(set) var fieldMap: [String: Any]?
	private(set) var body: [String: Any]?
	
	init(method: HTTPMethod, path: String?, headerMap: [String: String]?, queryMap: [String: Any]?, fieldMap: [String: Any]?, body: [String: Any]?) {
		
		self.method = method
		self.path = path
		self.headerMap = headerMap
		self.queryMap = queryMap
		self.fieldMap = fieldMap
		self.body = body
	}
	
	func getURLRequest(with endpoint: String) throws -> URLRequest {
		
		// create URLRequest using baseUrl and path
		let url = try endpoint.asURL()
		
		var urlRequest: URLRequest
		if let path = path, !path.isEmpty {
			urlRequest = URLRequest(url: url.appendingPathComponent(path))
		}
		else {
			urlRequest = URLRequest(url: url)
		}
		
		// set method
		urlRequest.httpMethod = method.rawValue
		
		// if has headerMap
		if let headerMap = headerMap {
			
			// set header
			for (key, value) in headerMap {
				urlRequest.setValue(value, forHTTPHeaderField: key)
			}
		}
		
		// if has queryMap
		if let queryMap = queryMap {
			
			// use URLEncoding to add queryMap in url
			urlRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: queryMap)
		}
		
		// if has fieldMap
		if let fieldMap = fieldMap {
			
			// use URL to add fieldMap in body
			urlRequest = try URLEncoding(destination: .httpBody).encode(urlRequest, with: fieldMap)
			
		} // else has body Mappable to json
		else if let body = body {
			
			// use JSON to add as json body
			urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
		}
		
		return urlRequest
	}
}
