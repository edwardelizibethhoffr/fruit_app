//
//  Logger.swift
//  Fruit App
//
//  Created by Calum Maclellan on 19/06/2021.
//

import Foundation

struct Logger {
    
    private static let apiLogger: APILoggingProtocol = APIService()
    
    static func makeLoggingRequest(eventType: UsageEventType, data: String) {
        apiLogger.makeUsageEventRequest(eventType: eventType, data: data)
    }
}
