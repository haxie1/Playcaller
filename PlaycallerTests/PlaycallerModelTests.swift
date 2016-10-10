//
//  PlaycallerModelTests.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/9/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import XCTest
import CoreData
@testable import Playcaller

class PlaycallerModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_creatingModel() {
        let model = PlaycallerModel()
        XCTAssert(model.persistentContainer.name == "Playcaller")
    }
    
    func test_creatingModelWithInMemoryType() {
        let model = PlaycallerModel(type:.inMemory)
        XCTAssert(model.type == .inMemory)
    }
    
    func test_creatingInMemoryModelSetsCorrectDescriptionOnContainer() {
        let model = PlaycallerModel(type:.inMemory)
        let inMemoryType = model.persistentContainer.persistentStoreDescriptions.contains(where: { $0.type == NSInMemoryStoreType })
        XCTAssertTrue(inMemoryType)
    }
    
    func test_loadingPlayerModelUsingInMemoryStore() {
        let model = PlaycallerModel(type: .inMemory)
        
        model.load { (error) in
            XCTAssertNil(error)
        }
    }
    
    func test_mainContext() {
        let model = PlaycallerModel(type: .inMemory)
        XCTAssert(model.mainContext == model.persistentContainer.viewContext)
    }
    
    func test_creatingATeamProfile() {
        let model = PlaycallerModel(type: .inMemory)
        model.load { XCTAssertNil($0) }
        
        let teamProfile = TeamProfile(context: model.persistentContainer.viewContext)
        teamProfile.name = "My Name"
        
        try? model.persistentContainer.viewContext.save()
        let count = try? model.persistentContainer.viewContext.count(for: TeamProfile.fetchRequest())
        XCTAssert(count == 1)
    }
    
    func test_fetchingAProfile() {
        let model = PlaycallerModel(type: .inMemory)
        let _ = TeamProfile(context: model.mainContext)
        let profile: TeamProfile? = model.fetchFirst(TeamProfile.fetchRequest())
        XCTAssertNotNil(profile)
    }
}
