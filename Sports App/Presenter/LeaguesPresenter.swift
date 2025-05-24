//
//  LeaugesPresenter.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 30/01/2025.
//

import Foundation

class LeaguesPresenter {
    var view : LeaguesView?
    
    
    func getLeagues(sport : String){
        
        var leaguesList : [League] = []
        
        Services.fetchDataFromJSON(sport: sport) { res in
            leaguesList = res?.result ?? []
            self.view?.showLeagues(leagues: leaguesList)

        }

    }
    func attachView(view : LeaguesView) {
        self.view = view
    }
}
