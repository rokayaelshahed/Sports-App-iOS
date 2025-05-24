//
//  FakeNetwork.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 03/02/2025.
//
import Foundation
@testable import Sports_App

class FakeNetwork {
    var shouldReturnError: Bool
    var responseError: Error?

    let jsonResponse: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 1,
                "league_name": "Premier League",
                "league_logo": "https://someurl.com/logo.png"
            ],
            [
                "league_key": 2,
                "league_name": "La Liga",
                "league_logo": "https://someurl.com/logo2.png"
            ]
        ]
    ]
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func loadData(url: String, completionHandler: @escaping (LeagueResponse?, Error?) -> Void) {
        if shouldReturnError {
            
            completionHandler(nil, responseError)
        } else {

            do {
                let data = try JSONSerialization.data(withJSONObject: jsonResponse, options: [])
                let decodedResponse = try JSONDecoder().decode(LeagueResponse.self, from: data)
                completionHandler(decodedResponse, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
}
