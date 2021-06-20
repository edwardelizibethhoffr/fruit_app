//
//  MockAPILogger.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//
@testable import Fruit_App
import Foundation

class MockAPILogger: APILoggingProtocol {

    var invokedMakeUsageEventRequest = false
    var invokedMakeUsageEventRequestCount = 0
    var invokedMakeUsageEventRequestParameters: (eventType: UsageEventType, data: String)?
    var invokedMakeUsageEventRequestParametersList = [(eventType: UsageEventType, data: String)]()

    func makeUsageEventRequest(eventType: UsageEventType, data: String) {
        invokedMakeUsageEventRequest = true
        invokedMakeUsageEventRequestCount += 1
        invokedMakeUsageEventRequestParameters = (eventType, data)
        invokedMakeUsageEventRequestParametersList.append((eventType, data))
    }
}
