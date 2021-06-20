//
//  MockURLSession.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

import Foundation

class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    var dataTaskWithRequestCallCounter = 0
    
    var dataTask: MockURLSessionDataTask = MockURLSessionDataTask(response: nil, currentRequest: nil)
    
    var lastRequest: URLRequest?
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        dataTaskWithRequestCallCounter += 1
        lastRequest = request
        return dataTask
    }
    
    func setResponse(_ response: MockHTTPURLResponse?) {
        dataTask.httpUrlResponse = response
    }
    
}
