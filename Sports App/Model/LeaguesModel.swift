//
//  LeaguesModel.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 30/01/2025.
//
import Foundation

struct LeagueResponse: Codable {
    let success: Int
    let result: [League]
}

struct League: Codable {
    let league_key: Int
    let league_name: String
//    let country_key: Int
//    let country_name: String
    let league_logo: String?
   // let country_logo: String?
}
struct LeagueCore{
    let sport: String?
    let name: String
    let logo: String?
    let key: Int
}


