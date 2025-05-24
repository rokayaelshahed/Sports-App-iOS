//
//  CoreDataManager.swift
//  MovieListD2
//
//  Created by Rokaya El Shahed on 17/01/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
        
    private init() { }
    
    lazy var  persistentContainer : NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Sports_App")
            container.loadPersistentStores { _, error in
                if let error {
                    print(error.localizedDescription)
                }
            }
            return container
        }()
    var context: NSManagedObjectContext {
         return persistentContainer.viewContext
    }
    
    func saveLeague(league: LeagueCore) {
      //  for league in leagues {
        let fetchRequest: NSFetchRequest<LeagueList> = LeagueList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %d", league.key)
        do {
               let existingLeagues = try context.fetch(fetchRequest)
            if existingLeagues.isEmpty {
                let newLeague = LeagueList(context: context)
                newLeague.key = Int32(league.key)
                newLeague.logo = league.logo
                newLeague.name = league.name
                newLeague.sport = league.sport
                //   }
                //  do {
                try context.save()}
            else{
                print("League already exists in Core Data.")
            }
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func fetchLeagues() -> [LeagueCore] {
        let fetchRequest: NSFetchRequest<LeagueList> = LeagueList.fetchRequest()
        var leagues: [LeagueCore] = []

        do {
            let leagueListEntities = try context.fetch(fetchRequest)
            for item in leagueListEntities {
                let league = LeagueCore(
                    
                    sport: item.sport ?? "",
                    name: item.name ?? "",
                    logo: item.logo ?? "Unknown",
                    key: Int(item.key)
                )
                leagues.append(league)
            }

            
            return leagues
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            return []
        }
    }
    
}

