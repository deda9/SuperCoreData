//
//  SuperCoreDataTests.swift
//  SuperCoreDataTests
//
//  Created by Bassem Qoulta on 11/13/18.
//  Copyright © 2018 Bassem Qoulta. All rights reserved.
//

import XCTest
import CoreData
import Foundation.NSPredicate

@testable import SuperCoreData
class SuperCoreDataTests: XCTestCase {
    
    var sut: SuperCoreData!
    
    override func setUp() {
        sut = SuperCoreData.default
        sut.modelName = "SuperCoreDataModel"
    }
    
    override func tearDown() {}
    
    func testSave() {
        let person: Person = sut.defaultContext.createEntity()
        person.name = "Deda"
        person.email = "Deda@gmail.com"
        person.title = "Developer"
        person.age = 28
        sut.defaultContext.save { isSuccess in
            XCTAssertTrue(isSuccess, "Error while save person")
        }
    }
    
    func testRead() {
        let perdicate = NSPredicate.init(format: "name == %@", "Deda")
        let person: Person? = sut.defaultContext.fetchFirst(Person.self, predicate: perdicate)
        XCTAssertNotNil(person, "Errro while getting the name")
    }
    
    func testPersonCount() {
        let personsCount = Person.count()
        XCTAssertTrue(personsCount > 0, "Not found perosons in DataBase")
    }
}
