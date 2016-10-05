//
//  CoordinatorTests.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/4/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import XCTest
@testable import Playcaller

enum Status {
    case ready
    case started
}

class TestCoordinator: Coordinator {
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    var status: Status = .ready
    
    private (set) var managedController: UIViewController
    
    required init(with managedController: UIViewController) {
        self.managedController = managedController
    }
    
    func start() {
        self.status = .started
    }
    
    func end() {
        self.status = .ready
    }
}

class CoordinatorTests: XCTestCase {
    var coordinator: TestCoordinator!
    
    override func setUp() {
        super.setUp()
        let testVC = UIViewController()
        self.coordinator = TestCoordinator(with: testVC)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    func test_createACoordinator() {
        let coordinator = TestCoordinator(with: UIViewController())
        XCTAssertNotNil(coordinator)
    }
    
    func test_createWithAManagedControllerType() {
        let vc = UIViewController()
        let coordinator = TestCoordinator(with: vc)
        XCTAssert(coordinator.managedController == vc)
    }
    
    func test_createdWithAnEmptyChildrenArray() {
        XCTAssert(self.coordinator.children.count == 0)
    }
    
    func test_pushingChildCoordinator() {
        let child = self.setupChild()
        XCTAssert(self.coordinator.children.count == 1)
        XCTAssertTrue(self.coordinator.children.contains(where: { $0 === child }))
    }
    
    func test_pushingChildCoordinatorSetsItsParent() {
        let child = self.setupChild()
        XCTAssertNotNil(child.parent)
        XCTAssert(child.parent === self.coordinator)
    }
    
    func test_poppingChildCoordinator() {
        let child = self.setupChild()
        let last = self.coordinator.pop()
        XCTAssert(last === child)
    }
    
    func test_poppingChildCoordinatorRemovesParent() {
        let child = self.setupChild()
        self.coordinator.pop()
        XCTAssertNil(child.parent)
    }
    
    func test_currentCoordinator() {
        self.setupChild()
        XCTAssertNotNil(self.coordinator.currentCoordinator)
    }
    
    func test_currentCoordinatorReturnsLastChild() {
        self.setupChild()
        let child2 = TestCoordinator(with: UIViewController())
        self.coordinator.push(coordinator: child2)
        XCTAssert(self.coordinator.currentCoordinator === child2)
    }
    
    func test_startingACoordinator() {
        // mainly just a test to make sure that .start() is added to the protocol and is not optional
        self.coordinator.start()
        XCTAssertTrue(self.coordinator.status == .started)
    }
    
    func test_endingACoordinator() {
        // mainly just a test to make sure that .end() is added to the protocol and is not optional
        self.coordinator.end()
        XCTAssertTrue(self.coordinator.status == .ready)
    }
    
    @discardableResult private func setupChild() -> Coordinator {
        let child = TestCoordinator(with: UIViewController())
        self.coordinator.push(coordinator: child)
        return child
    }
}
