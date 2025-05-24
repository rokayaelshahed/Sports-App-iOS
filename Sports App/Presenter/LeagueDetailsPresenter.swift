//
//  LeagueDetailsPresenter.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 01/02/2025.
//

import Foundation

class LeagueDetailsPresenter {
    var view : LeaguesDetailsView?
    

    func getLeagueDetails(sport: String, leagueKey: Int ) {
        
        //https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=ac0549804ac408e5e58c27c4d6a2032a7d806541a795daea11e1e49ed2466cfa&from=2021-05-18&to=2025-02-03
        let start = "2021-05-18"
        let today = "2025-02-03"
        let future = "2025-12-29"
        var upcomingEvents : [Fixture] = []
        var latestResults : [Fixture] = []
        
//        LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport ,from: today , to: future) { res in
//            upcomingEvents = res?.result ?? []
//            DispatchQueue.main.async {
//                self.view?.showLeagueDetails(upcomingEvents:  upcomingEvents)
//            }
//            }
//        
//        LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport ,from: start , to: today) { res in
//            latestResults = res?.result ?? []
//            DispatchQueue.main.async {
//                self.view?.showLeagueDetails2(latestResults: latestResults)
//            }
        DispatchQueue.global().async {
               LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport, from: today, to: future) { res in
                   upcomingEvents = res?.result ?? []
                   
                   // Update UI after background work is done
                   DispatchQueue.main.async {
                       self.view?.showLeagueDetails(upcomingEvents: upcomingEvents)
                   }
               }
           }
           
           // Fetch Latest Results on Background Thread
           DispatchQueue.global().async {
               LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport, from: start, to: today) { res in
                   latestResults = res?.result ?? []
                   
                   // Update UI after background work is done
                   DispatchQueue.main.async {
                       self.view?.showLeagueDetails2(latestResults: latestResults)
                   }
               }
        }
    }

    func getTeams(leagueKey : Int ,sport : String){
        
        var TeamsList : [Team] = []
        
        TeamsServices.fetchDataFromJSON(sport: sport,leagueId: leagueKey) { res in
            TeamsList = res?.result ?? []
            DispatchQueue.main.async {
                self.view?.showTeams(teams: TeamsList)
            }
        }

    }
    
    func attachView(view : LeaguesDetailsView){
        self.view = view
    }
}
//        LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport ,from: start , to: today) { res in
//            guard let leagueFixtures = res?.result else {
//                print("❌ No league fixtures found for leagueKey: \(leagueKey)")
//                self.view?.showLeagueDetails(upcomingEvents: [], latestResults: [])
//                return
//            }
//            if let allResults = res?.result {
//                print("✅ API returned \(allResults.count) results.")
//               // print(allResults)  // Debug: Print full API response
//            } else {
//                print("❌ API response is nil or empty.")
//            }
//                guard let leagueFixtures = res?.result, !leagueFixtures.isEmpty else {
//                           print("❌ No data received for leagueKey: \(leagueKey)")
//                           self.view?.showLeagueDetails(upcomingEvents: [], latestResults: [])
//                           return
//                       }

//            let today = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"

//            let upcomingEvents = leagueFixtures.filter {
//                guard let eventDate = dateFormatter.date(from: $0.event_date!) else { return false }
//                return eventDate > today
//            }
//            let calendar = Calendar.current
//
//            let upcomingEvents = leagueFixtures.filter {
//                guard let eventDate = dateFormatter.date(from: $0.event_date ?? "") else { return false }
//                let eventMonth = calendar.component(.month, from: eventDate)
//                return eventMonth >= 1 // Events from February onward
//            }

//            let latestResults = leagueFixtures.filter {
//                guard let eventDate = dateFormatter.date(from: $0.event_date!) else { return false }
//                return eventDate <= today
//            }
//            let upcomingEvents = leagueFixtures.filter { event in
//                return event.event_ft_result?.isEmpty ?? true
//               }
//            let latestResults = leagueFixtures.filter { event in
//                return !(event.event_ft_result?.isEmpty ?? true )
//               }
//            print("✅ Fetched \(upcomingEvents.count) upcoming events and \(latestResults.count) latest results.")
            
        //    DispatchQueue.main.async {
//                self.view?.showLeagueDetails(upcomingEvents: upcomingEvents, latestResults: latestResults)
        //    }
       // }

//    func getLeagueDetails(sport : String , leagueKey : Int){
//
//        var leagueDetailsList : [Fixture] = []
//
//        LeagueDetailsServices.fetchDataFromJSON(leagueKey: leagueKey, sport: sport) { res in
//            let leagueFixtures = res?.result.filter { $0.league_key == leagueKey }
//            let today = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let upcomingEvents = leagueFixtures?.filter {
//            guard let eventDate = dateFormatter.date(from: $0.event_date) else { return false }
//                return eventDate > today
//                           }
//            let latestResults = leagueFixtures?.filter {
//            guard let eventDate = dateFormatter.date(from: $0.event_date) else { return false }
//                               return eventDate <= today
//                           }
//
//            self.view?.showLeagueDetails(upcomingEvents: upcomingEvents!, latestResults: latestResults!)
////            leagueDetailsList = res?.result ?? []
////            self.view?.showLeagues(leagues: leaguesList)
//
//        }
//
//    }
