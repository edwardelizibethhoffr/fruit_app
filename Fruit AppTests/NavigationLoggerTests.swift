//
//  NavigationLoggerTests.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

@testable import Fruit_App
import XCTest

class NavigationLoggerTests: XCTestCase {

    var mockLogger: MockLogger!
    
    override func setUpWithError() throws {
        mockLogger = MockLogger()
        NavigationLogger.instance.setLogger(mockLogger)
    }
    
    func testNavLoggerCallsLoggerWhenNavigationEventEnds() {
        let id: ObjectIdentifier = ObjectIdentifier(NSObject())
        
        NavigationLogger.navigationEventStarted(id: id)
        NavigationLogger.navigationEventEnded(id: id)
        
        XCTAssertEqual(mockLogger.invokedMakeLoggingRequestCount, 1)
    }

    func testNavLoggerDoesNotCallLoggerWhenIdsDoNotMatch() {
        let idOne: ObjectIdentifier = ObjectIdentifier(NSObject())
        let idTwo: ObjectIdentifier = ObjectIdentifier(MockLogger())
        
        NavigationLogger.navigationEventStarted(id: idOne)
        NavigationLogger.navigationEventEnded(id: idTwo)
        
        XCTAssertEqual(mockLogger.invokedMakeLoggingRequestCount, 0)
    }

}
