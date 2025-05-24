//
//  MockNetworkManager.swift
//  Sports AppTests
//
//  Created by Rokaya El Shahed on 03/02/2025.
//

import XCTest

final class MockNetworkManager: XCTestCase {

    var fakeNetwork : FakeNetwork!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeNetwork = FakeNetwork(shouldReturnError: false)

    }

    override func tearDownWithError() throws {
        fakeNetwork = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testDataFromAPI_Success() {
            let expectation = self.expectation(description: "Fetching data from fake network")

            fakeNetwork.loadData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa") { leagueResponse, error in
               
                XCTAssertNil(error)
                XCTAssertNotNil(leagueResponse)
             
                expectation.fulfill()
            }

        
            waitForExpectations(timeout: 1, handler: nil)
        }

        func testDataFromAPI_Error() {

            fakeNetwork = FakeNetwork(shouldReturnError: true)
            
            let expectation = self.expectation(description: "Fetching data from fake network")

          
            fakeNetwork.loadData(url: "https://fakeurl.com") { leagueResponse, error in
                
                XCTAssertNil(error)
                XCTAssertNil(leagueResponse)
                expectation.fulfill()
            }

            waitForExpectations(timeout: 1, handler: nil)
        }
    }


