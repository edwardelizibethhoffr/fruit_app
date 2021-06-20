//
//  MockHTTPURLResponse.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

import Foundation

class MockHTTPURLResponse: HTTPURLResponse {
    
    var mockStatusCode: Int = 200
    
    init?(statusCode: Int = 200) {
        mockStatusCode = statusCode
        super.init(url: URL(string: "mock.test")!, statusCode: mockStatusCode, httpVersion: nil, headerFields: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var statusCode: Int {
        return mockStatusCode
    }
}
