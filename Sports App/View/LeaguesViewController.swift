//
//  LeaguesViewController.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 30/01/2025.
//

import UIKit
import SDWebImage

protocol LeaguesView{
    func showLeagues(leagues: [League])
}

class LeaguesViewController: UITableViewController,LeaguesView {
    var leagues:[League] = []
    var selectedSport: String?
    func showLeagues(leagues: [League]) {
        
        DispatchQueue.main.async {
            self.leagues = leagues
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Leagues"
        let presenter = LeaguesPresenter()
        presenter.attachView(view: self)
        if let sport = selectedSport {
            presenter.getLeagues(sport: sport)
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        let league = leagues[indexPath.row]
        cell.leagueNameLabel?.text = league.league_name
        //cell.imageView?.image = UIImage(named: "football")
        if let logo = league.league_logo, let logoURL = URL(string: logo) {
            cell.leagueImg?.sd_setImage(with: logoURL, placeholderImage: UIImage(named: "test"))
        } else {
            cell.leagueImg?.image = UIImage(named: "test")
        }
        //        if let imageView = cell.imageView {
        ////                imageView.layer.cornerRadius = imageView.frame.size.width / 2
        ////                imageView.clipsToBounds = true
        //            imageView.backgroundColor = .darkGray
        //            }
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLeague = leagues[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as? LeaguesDetailsCollectionViewController {
        detailsVC.leagueKey = selectedLeague.league_key
           // detailsVC.leagueKey = 633

            detailsVC.sportType = selectedSport
            let l = LeagueCore  (
                sport: selectedSport,
                name: selectedLeague.league_name,
                logo: selectedLeague.league_logo,
                key: selectedLeague.league_key
            )
            detailsVC.league = l
            navigationController?.pushViewController(detailsVC, animated: true)
            //fetchLeagueDetails(leagueKey: selectedLeague.league_key)
        }
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
