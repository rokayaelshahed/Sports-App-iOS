//
//  LeagueDetailsModel.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 31/01/2025.
//

import Foundation
struct LeagueDetailsResponse: Codable {
    
    let success: Int
    let result: [Fixture]
}

struct Fixture: Codable {
    
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_logo: String?
    let event_away_team: String?
    let away_team_logo: String?
    let league_key: Int?
    let event_ft_result: String?

}
struct TeamsResponse: Codable {
    
    let success: Int
    let result: [Team]
}
struct Team: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
   
}
//struct Coach: Codable {
//  let coaches: [Coach]?
//
//    let coach_name :String?
//    let coach_country :String?
//    let coach_age : String?
//}
