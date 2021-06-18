//
//  APIServiceProtocol.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    
    func makeGetFruitRequest() -> AnyPublisher<FruitResponse, FruitError>
    
    func makeUsageEventRequest(eventType: UsageEventType, data: String)
    
}
