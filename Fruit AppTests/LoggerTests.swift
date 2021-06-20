//
//  LoggerTests.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

import XCTest
@testable import Fruit_App

class LoggerTests: XCTestCase {

    var logger: Logger!
    var mockAPILogger: MockAPILogger!
    
    override func setUpWithError() throws {
        mockAPILogger = MockAPILogger()
        logger = Logger(mockAPILogger)
    }
    
    func testMakeLoggingRequestCallsAPILogger() {
        logger.makeLoggingRequest(eventType: .display, data: "TestString")
        XCTAssertEqual(mockAPILogger.invokedMakeUsageEventRequestCount, 1)
        XCTAssertEqual(mockAPILogger.invokedMakeUsageEventRequestParametersList.first?.eventType, .display)
    }

}
