//
//  ResultsCollectionViewCell.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 31/01/2025.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myImg.layer.cornerRadius = myImg.frame.size.width / 2
        myImg.clipsToBounds = true
        myImg.backgroundColor = .black

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
