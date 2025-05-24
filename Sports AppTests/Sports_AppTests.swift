//
//  Sports_AppTests.swift
//  Sports AppTests
//
//  Created by Rokaya El Shahed on 29/01/2025.
//

import XCTest
@testable import Sports_App

final class Sports_AppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchDataFromJSON() {
        
        let expectation = self.expectation(description: "Waiting for API response")
        
        Services.fetchDataFromJSON(sport : "football") { leagueResponse in
            
            
            XCTAssertNotNil(leagueResponse)
            
            XCTAssertEqual(leagueResponse?.success, 1)
            
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
