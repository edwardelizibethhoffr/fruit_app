//
//  NavigationLoggerProtocol.swift
//  Fruit App
//
//  Created by Calum Maclellan on 19/06/2021.
//

import Foundation

protocol NavigationLoggerProtocol {
    
    static func navigationEventStarted(id: ObjectIdentifier)
    
    static func navigationEventEnded(id: ObjectIdentifier)
    
}
