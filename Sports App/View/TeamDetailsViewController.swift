//
//  TeamDetailsViewController.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 03/02/2025.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    var team: Team!
    var sport: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameLabel.text = team.team_name
        sportName.text = sport
        if let logo = team.team_logo, let teamLogoURL = URL(string: team.team_logo ?? " "){
            teamImg?.sd_setImage(with: teamLogoURL, placeholderImage: UIImage(named: "test"))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
