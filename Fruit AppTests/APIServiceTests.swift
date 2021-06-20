//
//  APIServiceTests.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//


@testable import Fruit_App
import XCTest
import Combine

class APIServiceTests: XCTestCase {
    
    var apiService: APIService!
    var session: URLSession!
    var mockSession: MockURLSession!
    
    let dataURLString = " https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
    
    override func setUpWithError() throws {
        mockSession = MockURLSession()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }
        
        session = URLSession(configuration: configuration)
        apiService = APIService(session)
    }
    
    
    func testMakeGetFruitRequestMakesRequest() {
        let sampleData = FruitResponse(fruit: [Fruit(type: "test", price: 1, weight: 1)])
        let mockData = try! JSONEncoder().encode(sampleData)
        let expectation = XCTestExpectation(description: "response")
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        apiService.makeGetFruitRequest()
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: {_ in}, receiveValue: {
            response in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
       
    }
    
    func testMakeUsageEventRequestMakesRequest() {
        apiService = APIService(mockSession)
        let initDataTaskCounter = mockSession.dataTaskWithRequestCallCounter
        
        let expectedString =
            "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=error&data=Test"
        
        apiService.makeUsageEventRequest(eventType: .error, data: "Test")
        
        XCTAssertEqual(initDataTaskCounter + 1, mockSession.dataTaskWithRequestCallCounter)
        XCTAssertEqual(mockSession.lastRequest?.url?.absoluteString, expectedString)
    }
    
    func testUrlSessiondidCompleteWithErrorLogsAnyErrors() {
        apiService = APIService(mockSession)
        let initDataTaskCounter = mockSession.dataTaskWithRequestCallCounter
      
        apiService.urlSession(MockURLSession(), task: MockURLSessionTask(), didCompleteWithError: FruitError.network(description: "TestError"))
        
        XCTAssertEqual(initDataTaskCounter + 1, mockSession.dataTaskWithRequestCallCounter)
     
    }
    
}
