//
//  LeagueDetailsService.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 01/02/2025.
//

import Foundation

protocol NetworkLeagueDetailsProtocol {
    static func fetchDataFromJSON(leagueKey: Int,sport: String,from: String, to: String, completion: @escaping (LeagueDetailsResponse?)-> Void )
}

class LeagueDetailsServices : NetworkLeagueDetailsProtocol {
    
    static var result: LeagueDetailsResponse?
    static func fetchDataFromJSON(leagueKey: Int,sport: String,from: String, to: String
                                  ,completion: @escaping (LeagueDetailsResponse?)-> Void ) {
        //
                let apiKey = "ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa"
//               let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(apiKey)&leagueId=\(leagueKey)&from=2021-05-18&to=2025-02-10"
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=\(apiKey)&leagueId=\(leagueKey)&from=\(from)&to=\(to)"
//       https://apiv2.allsportsapi.com/football&APIkey=56eb8e9b98b07e7b09bee4217bb82621b88ff72ad858cb1bbd8eac1ff36db88b&met=Fixtures&leagueId=23&from=2025-01-20&to=2025-02-03 https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa&from=2025-01-20&to=2025-02-03
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
      
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print( error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print(" No data received from API")
                completion(nil)
                return
            }
            
//            if let dataString = String(data: data, encoding: .utf8) {
//                print("API Response: \(dataString)")
//            }
            
            do {
                let result = try JSONDecoder().decode(LeagueDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("JSON Decoding Error:", error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
       
}

protocol TeamsNetworkProtocol {
    static func fetchDataFromJSON(sport: String,leagueId: Int, completion: @escaping (TeamsResponse?)-> Void )
}

class TeamsServices : TeamsNetworkProtocol {
    static var result: TeamsResponse?
    static func fetchDataFromJSON(sport: String
                                  ,leagueId: Int,completion: @escaping (TeamsResponse?)-> Void ) {
        let apiKey = "ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa"
//        let urlString = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Teams&APIkey=\(apiKey)&leagueId=\(leagueId)"
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa&leagueId=\(leagueId)"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print( error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print(" No data received from API")
                completion(nil)
                return
            }
            
//            if let dataString = String(data: data, encoding: .utf8) {
//                print("API Response: \(dataString)")
//            }
            
            do {
                let result = try JSONDecoder().decode(TeamsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("JSON Decoding Error:", error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            
//            do {
//                result = try JSONDecoder().decode(TeamsResponse.self, from: data)
//                completion(result)
//            }catch {
//                print(error.localizedDescription)
//                completion(nil)
//            }
//        }
//        task.resume()
    }
       
}
