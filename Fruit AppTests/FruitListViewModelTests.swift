//
//  FruitListViewModelTests.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//
@testable import Fruit_App
import XCTest
import Combine

class FruitListViewModelTests: XCTestCase {

    var viewModel: FruitListViewModel!
    var mockApiService: MockAPIService!
    var mockLogger: MockLogger!
    var fruitArray: [Fruit] = []
    
    override func setUpWithError() throws {
        fruitArray = [Fruit(type: "One", price: 1, weight: 1), Fruit(type: "Two", price: 2, weight: 2)]
        
        mockApiService = MockAPIService()
        mockLogger = MockLogger()
        viewModel = FruitListViewModel(apiService: mockApiService, logger: mockLogger)
    }

    func testApiServiceIsCalledOnInitialisation() {
        XCTAssertEqual(mockApiService.invokedMakeGetFruitRequestCount, 1)
    }
    
    func testGetFruitCallsApiService() {
        let initCallCount = mockApiService.invokedMakeGetFruitRequestCount
        viewModel.getFruit()
        XCTAssertEqual(mockApiService.invokedMakeGetFruitRequestCount, initCallCount + 1)
    }
    
    func testGetFruitSetsDatasource() {
        let exp = expectValue(of: viewModel.$dataSource.eraseToAnyPublisher(), equals:
                                [{ $0.first?.getType() ==  "One" }])
    
        viewModel.getFruit()
        
        mockApiService.makeGetFruitRequestResultSubject.send(FruitResponse(fruit: fruitArray))

        wait(for: [exp.expectation], timeout: 1)
        XCTAssertEqual(self.viewModel.dataSource.count, 2)
    }
    
    func testGetFruitCallsLoggerOnFailure() {
        
        let failureMessage = "Test failure"
        
        let exp: CompletionResult = expectValue(of: mockLogger.$invokedMakeLoggingRequestCount.eraseToAnyPublisher(), equals:[{ $0 ==  1 }])
        
        XCTAssertEqual(mockLogger.invokedMakeLoggingRequestCount, 0)
        viewModel.getFruit()
        
        mockApiService.makeGetFruitRequestResultSubject.send(completion: .failure(FruitError.network(description: failureMessage)))
    
        wait(for: [exp.expectation], timeout: 2)
    }
   
}


extension XCTestCase {
    
    typealias CompletionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    func expectCompletion<T: Publisher>(of publisher: T,
                                          timeout: TimeInterval = 2,
                                          file: StaticString = #file,
                                          line: UInt = #line) -> CompletionResult {
        let exp = expectation(description: "Successful completion of " + String(describing: publisher))
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
            if case .finished = completion {
                exp.fulfill()
            }
        }, receiveValue: { _ in })
        return (exp, cancellable)
    }
    
    func expectValue<T: Publisher>(of publisher: T,
                                       timeout: TimeInterval = 2,
                                       file: StaticString = #file,
                                       line: UInt = #line,
                                       equals: [(T.Output) -> Bool])
            -> CompletionResult {
            let exp = expectation(description: "Correct values of " + String(describing: publisher))
            var mutableEquals = equals
            let cancellable = publisher
                .sink(receiveCompletion: { _ in },
                      receiveValue: { value in
                          if mutableEquals.first?(value) ?? false {
                              _ = mutableEquals.remove(at: 0)
                              if mutableEquals.isEmpty {
                                  exp.fulfill()
                              }
                          }
                })
            return (exp, cancellable)
        }
    
}
