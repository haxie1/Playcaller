//
//  EventDistributerTests.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/5/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import XCTest
@testable import Events

class TestHandler: EventHandler {
    var recievedEvent: Bool = false
    func handle<T: Event>(event: T) {
        self.recievedEvent = true
    }
}

struct TestEvent: Event {
    var eventData: Int = 0
}

class EventDistributerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        EventDistributer.shared.unregisterAll()
        super.tearDown()
    }
    
    func test_creatingASharedInstance() {
        let distributer = EventDistributer.shared
        XCTAssert(distributer === EventDistributer.shared)
    }
    
    func test_registeringAnEventHandler() {
        EventDistributer.shared.register(handler: TestHandler())
        XCTAssert(EventDistributer.shared.registryCount == 1)
    }
    
    func test_registeringAHandlerReturnsAUUID() {
        let uuid = EventDistributer.shared.register(handler: TestHandler())
        XCTAssert(type(of: uuid) == UUID.self)
    }
    
    func test_unregisteringAHandlerUsingAUUID() {
        let uuid = EventDistributer.shared.register(handler: TestHandler())
        let registryCount = EventDistributer.shared.registryCount
        EventDistributer.shared.unregister(with: uuid)
        XCTAssert(EventDistributer.shared.registryCount == (registryCount - 1))
    }
    
    func test_unregisteringAllHandlers() {
        EventDistributer.shared.register(handler: TestHandler())
        EventDistributer.shared.register(handler: TestHandler())
        EventDistributer.shared.unregisterAll()
        XCTAssert(EventDistributer.shared.registryCount == 0)
    }
    
    func test_distributingAnEventToRegisteredHandlers() {
        let testHandler = TestHandler()
        EventDistributer.shared.register(handler: testHandler)
        let testEvent = TestEvent()
        EventDistributer.shared.distribute(event: testEvent)
        XCTAssertTrue(testHandler.recievedEvent)
    }
    
    func test_distributingAnEventCleansUpStaleRegisteredHandlers() {
        var testHandler: TestHandler? = TestHandler()
        EventDistributer.shared.register(handler: testHandler!)
        XCTAssert(EventDistributer.shared.registryCount == 1)
        testHandler = nil // simulate a handler getting deallocated. reference types should be handled weakly by the EventDistributer
        EventDistributer.shared.distribute(event: TestEvent())
        XCTAssert(EventDistributer.shared.registryCount == 0)
    }
}
