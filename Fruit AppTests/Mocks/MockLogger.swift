//
//  MockLogger.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//
@testable import Fruit_App
import Foundation

class MockLogger: ObservableObject, LoggerProtocol {

    @Published var invokedMakeLoggingRequest: Bool = false
    @Published  var invokedMakeLoggingRequestCount = 0
    var invokedMakeLoggingRequestParameters: (eventType: UsageEventType, data: String)?
    @Published var invokedMakeLoggingRequestParametersList: [(eventType: UsageEventType, data: String)] = [(eventType: UsageEventType, data: String)]()

    func makeLoggingRequest(eventType: UsageEventType, data: String) {
        invokedMakeLoggingRequest = true
        invokedMakeLoggingRequestCount += 1
        invokedMakeLoggingRequestParameters = (eventType, data)
        invokedMakeLoggingRequestParametersList.append((eventType, data))
    }
}
  
