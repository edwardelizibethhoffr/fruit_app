//
//  NavigationLogger.swift
//  Fruit App
//
//  Created by Calum Maclellan on 19/06/2021.
//

import Foundation

class NavigationLogger: NavigationLoggerProtocol {

    private static var idsAndStartTimes: [ObjectIdentifier: Date] = [:]
    
    static var instance = NavigationLogger()
    
    private static var logger: LoggerProtocol = Logger()
    
    private init() {
    }
    
    func setLogger(_ logger: LoggerProtocol) {
        NavigationLogger.logger = logger
    }
    
    static func navigationEventStarted(id: ObjectIdentifier) {
        idsAndStartTimes[id] = Date()
    }
    
    static func navigationEventEnded(id: ObjectIdentifier) {
        guard let initTime = idsAndStartTimes.removeValue(forKey: id) else {
            return
        }
        let timeTaken = Int( Date().timeIntervalSince(initTime) * 1000)
        print("Time taken \(timeTaken)")
        logger.makeLoggingRequest(eventType: .display, data: "\(timeTaken)")
    }
    
}
