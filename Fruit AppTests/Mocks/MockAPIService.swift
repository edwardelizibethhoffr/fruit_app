//
//  MockAPIService.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//
@testable import Fruit_App
import Combine
import Foundation

class MockAPIService: APIServiceProtocol {

    var invokedMakeGetFruitRequest = false
    var invokedMakeGetFruitRequestCount = 0
    var makeGetFruitRequestResultSubject: PassthroughSubject<FruitResponse, FruitError>
    
    var fruitResponse: FruitResponse
    
    init() {
        makeGetFruitRequestResultSubject = PassthroughSubject<FruitResponse, FruitError>()
        let fruitArray = [Fruit(type: "One", price: 1, weight: 1), Fruit(type: "Two", price: 2, weight: 2)]
        fruitResponse = FruitResponse(fruit: fruitArray)
    }

    func makeGetFruitRequest() -> AnyPublisher<FruitResponse, FruitError> {
        invokedMakeGetFruitRequest = true
        invokedMakeGetFruitRequestCount += 1
        return makeGetFruitRequestResultSubject.eraseToAnyPublisher()
    }
}
