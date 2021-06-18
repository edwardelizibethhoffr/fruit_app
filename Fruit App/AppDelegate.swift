//
//  AppDelegate.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        NSSetUncaughtExceptionHandler { exception in
            print("Stack trace: \(exception.callStackSymbols)")
            APIService().makeUsageEventRequest(eventType: .error, data: "Uncaught Exception")
        }
        
        return true
    }
}
