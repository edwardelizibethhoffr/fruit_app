//
//  NavigationLoggingObject.swift
//  Fruit App
//
//  Created by Calum Maclellan on 20/06/2021.
//

import Foundation

protocol NavigationLoggingObjectProtocol {
    
    func logNavigationStarted()
    func logNavigationEnded()
}

class NavigationLoggingObject: Identifiable {
    
    func logNavigationStarted() {
        NavigationLogger.navigationEventStarted(id: id)
    }
    
    func logNavigationEnded() {
        NavigationLogger.navigationEventEnded(id: id)
    }
    
}


