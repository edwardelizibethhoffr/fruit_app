//
//  MockURLSessionTask.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

import Foundation

class MockURLSessionTask: URLSessionTask {
    
    var httpUrlResponse: HTTPURLResponse?
    var mockCurrentRequest: URLRequest?
    
    init(response: HTTPURLResponse? = nil, currentRequest: URLRequest? = nil) {
        self.mockCurrentRequest = currentRequest
        self.httpUrlResponse = response
        super.init()
    }
    
    override var response: URLResponse? {
        return httpUrlResponse
    }
    
    override var currentRequest: URLRequest? {
        return mockCurrentRequest
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    
    var httpUrlResponse: HTTPURLResponse?
    var mockCurrentRequest: URLRequest?
    
    init(response: HTTPURLResponse?, currentRequest: URLRequest?) {
        self.mockCurrentRequest = currentRequest
        self.httpUrlResponse = response
        super.init()
    }
    
    override var response: URLResponse? {
        return httpUrlResponse
    }
    
    override var currentRequest: URLRequest? {
        return mockCurrentRequest
    }
    
    override func resume() {
        return
    }
    
    override func cancel() {
        return
    }
    
}
