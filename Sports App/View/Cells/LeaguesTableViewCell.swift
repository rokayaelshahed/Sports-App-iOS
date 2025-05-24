//
//  LeaguesTableViewCell.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 30/01/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueImg.layer.cornerRadius = leagueImg.frame.size.width / 2
        leagueImg.clipsToBounds = true
        leagueImg.backgroundColor = .black

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
