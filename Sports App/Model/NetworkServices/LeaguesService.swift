//
//  LeagueService.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 30/01/2025.
//

import Foundation

protocol NetworkProtocol {
    static func fetchDataFromJSON(sport: String, completion: @escaping (LeagueResponse?)-> Void )
}

class Services : NetworkProtocol {
    static var result: LeagueResponse?
    static func fetchDataFromJSON(sport: String
                                  ,completion: @escaping (LeagueResponse?)-> Void ) {
        let apiKey = "ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa"
        let urlString = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            do {
                result = try JSONDecoder().decode(LeagueResponse.self, from: data)
                completion(result)
            }catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
       
}
