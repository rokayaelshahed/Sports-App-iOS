//
//  FavouritesTableViewController.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 29/01/2025.
//

import UIKit
import SDWebImage
import Reachability

class FavouritesTableViewController: UITableViewController {
    var leaguesData : [LeagueCore] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesData = CoreDataManager.shared.fetchLeagues()
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
        return leaguesData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableViewCell
        let favLeague = leaguesData[indexPath.row]
        cell.myLabel?.text = favLeague.name
        if let logo = favLeague.logo, let logoURL = URL(string: logo) {
            cell.myImg?.sd_setImage(with: logoURL, placeholderImage: UIImage(named: "test"))
        } else {
            cell.myImg?.image = UIImage(named: "test")
        }
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork(){
            let selectedLeague = leaguesData[indexPath.row]
            if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as? LeaguesDetailsCollectionViewController {
                detailsVC.leagueKey = selectedLeague.key
                // detailsVC.leagueKey = 633
                
                detailsVC.sportType = selectedLeague.sport
                //                let l = LeagueCore  (
                //                    sport: selectedSport,
                //                    name: selectedLeague.league_name,
                //                    logo: selectedLeague.league_logo,
                //                    key: selectedLeague.league_key
                //                )
                //                detailsVC.league = l
                navigationController?.pushViewController(detailsVC, animated: true)
            }
        }else {
            print("Network is not available")
            //alert
            let alert : UIAlertController = UIAlertController(title: "Internet Connection", message: "Check connection and try again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
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
