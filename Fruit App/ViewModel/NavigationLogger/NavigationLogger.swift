//
//  NavigationLogger.swift
//  Fruit App
//
//  Created by Calum Maclellan on 19/06/2021.
//

import Foundation

class NavigationLogger: NavigationLoggerProtocol {
    
    private var timeStarted: Date?
    
    func navigationEventStarted() {
        timeStarted = Date()
    }
    
    func navigationEventEnded() {
        guard let initTime = timeStarted else {
            return
        }
        let timeTaken = Int( Date().timeIntervalSince(initTime) * 1000)
        print("Time taken \(timeTaken)")
        timeStarted = nil
        Logger.makeLoggingRequest(eventType: .display, data: "\(timeTaken)")
    }
    
}
