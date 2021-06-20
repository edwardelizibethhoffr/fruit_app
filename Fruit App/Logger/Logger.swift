//
//  Logger.swift
//  Fruit App
//
//  Created by Calum Maclellan on 19/06/2021.
//

import Foundation

struct Logger: LoggerProtocol {
    
    private let apiLogger: APILoggingProtocol
    
    init(_ apiLogger: APILoggingProtocol = APIService()) {
        self.apiLogger = apiLogger
    }
    
    func makeLoggingRequest(eventType: UsageEventType, data: String) {
        apiLogger.makeUsageEventRequest(eventType: eventType, data: data)
    }
}

protocol LoggerProtocol {
    func makeLoggingRequest(eventType: UsageEventType, data: String) 
}
