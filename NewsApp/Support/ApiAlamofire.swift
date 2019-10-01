//
//  AlamoRestApi.swift
//  Link Up
//
//  Created by Thien Huynh on 10/1/19.
//  Copyright © 2019 Thien Huynh. All rights reserved.
//

import Alamofire

protocol AlamofireSession {
	func request(_ request: URLRequestConvertible) -> DataRequest
	func getErrorMessage<T>(_ response: DataResponse<T>) -> String
}

class ApiAlamofire: AlamofireSession {
	
	private var sessionManager: SessionManager
	
	// Singleton
	static let shared = ApiAlamofire()
	private init() {
		
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120 // large timeout for external api calls at server
        sessionManager = Alamofire.SessionManager(configuration: configuration)
	}
	
	func request(_ request: URLRequestConvertible) -> DataRequest {
		
		// using sessionManager
		return sessionManager.request(request)
			// validate to print response
			.validate(AlamofireUtils.printResponse)
			// validate() [200...299]
			.validate()
	}
    
	func getErrorMessage<T>(_ response: DataResponse<T>) -> String {
		return AlamofireUtils.getErrorMessage(response)
	}
}
