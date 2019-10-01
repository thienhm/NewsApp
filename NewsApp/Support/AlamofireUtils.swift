//
//  AlamofireUtils.swift
//  Link Up
//
//  Created by BJ Low on 21/4/17.
//  Copyright © 2017 Ozzie Tech Private Limited. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireUtils {
	
	static func getErrorMessage<T>(_ response: DataResponse<T>) -> String {
		
		return getErrorMessage(httpUrlResponse: response.response, data: response.data, error: response.error)
	}
	
	private static func getErrorMessage(httpUrlResponse: HTTPURLResponse?, data: Data?, error: Error?) -> String {
		
		var errorMessage: String
		
		// if have HTTPURLResponse, that means HTTP error
		if let httpUrlResponse = httpUrlResponse {
			
			// default to http status reason
			errorMessage = HTTPURLResponse.localizedString(forStatusCode: httpUrlResponse.statusCode)
			
			// if has body, use body as errorMessage
			if let data = data, let body = String(data: data, encoding: .utf8), !body.isEmpty {
				errorMessage = body as String
			}
		} // else network error
		else {
			// use error description
			errorMessage = error?.localizedDescription ?? "Unknown error"
		}
		
		return errorMessage
	}
	
	static func printRequest(urlRequest: URLRequest) {
		
		var result = "---> HTTP \(urlRequest.httpMethod!) \(urlRequest.url!)"
		
		// Add header fields.
		if let headers = urlRequest.allHTTPHeaderFields {
			for (key, value) in headers {
				result += "\n\(key) : '\(value)'"
			}
		}
		
		if let httpBody = urlRequest.httpBody, let body = String(data: httpBody, encoding: .utf8) {
			result += "\n\(body)"
		}
		
		print(result)
		print("---> END HTTP")
	}
	
	static func printResponse(urlRequest: URLRequest?, httpURLResponse: HTTPURLResponse?, data: Data?) -> Request.ValidationResult {
		
		var result: String = "<--- HTTP "
		
		if let httpURLResponse = httpURLResponse {
			
			result += "\(httpURLResponse.statusCode) \(httpURLResponse.url!)"
			
			for (key, value) in httpURLResponse.allHeaderFields {
				result += "\n\(key) = \(value)"
			}
		}
		
		// if have data body
		if let data = data, let body = String(data: data, encoding: .utf8), !body.isEmpty {
			result += "\n\(body)"
		}
		
		print(result)
		print("<--- END HTTP")
		
		return .success
	}
}
