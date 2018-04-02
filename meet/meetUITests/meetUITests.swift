//
//  meetUITests.swift
//  meetUITests
//
//  Created by Vlad Daneliuc on 26/03/2018.
//  Copyright © 2018 AgileFreaks. All rights reserved.
//

import XCTest

class meetUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func checkItinereayUI() {
        app.launch()
        let itineraryitemcellTable = app.tables["itineraryItemCell"]
        XCTAssertTrue(itineraryitemcellTable.exists)
        
        let cellCount = itineraryitemcellTable.children(matching: .cell).count - 1
        
        for index in 0...cellCount {
            itineraryitemcellTable.children(matching: .cell).element(boundBy: index).tap()
        }
        
        let myItineraryNavigationBar = app.navigationBars["My Itinerary"]
        XCTAssertTrue(myItineraryNavigationBar.otherElements["My Itinerary"].exists)
    }
    
}
