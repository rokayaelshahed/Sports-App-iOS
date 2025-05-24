//
//  ViewController.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 29/01/2025.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0  
            layout.minimumLineSpacing = 5
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray
        cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1 
        switch indexPath.row{
        case 0:
            (cell.viewWithTag(1) as! UILabel).text="Football"
            (cell.viewWithTag(2) as! UIImageView).image=UIImage(named: "football")
        case 1:
            (cell.viewWithTag(1) as! UILabel).text="BasketBall"
            (cell.viewWithTag(2) as! UIImageView).image=UIImage(named: "basketball")
        case 2:
            (cell.viewWithTag(1) as! UILabel).text="Cricket"
            (cell.viewWithTag(2) as! UIImageView).image=UIImage(named: "cricket")
        case 3:
            (cell.viewWithTag(1) as! UILabel).text="Tennis"
            (cell.viewWithTag(2) as! UIImageView).image=UIImage(named: "tennis")
        default:

            (cell.viewWithTag(1) as! UILabel).text="Cricket"
            (cell.viewWithTag(2) as! UIImageView).image=UIImage(named: "11")
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2-10, height: collectionView.frame.size.height/2-60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let leaguesVC = self.storyboard?.instantiateViewController(withIdentifier: "leaguesVC") as? LeaguesViewController {
            let sportNames = ["Football", "Basketball", "Cricket", "Tennis"]
            
                    leaguesVC.selectedSport = sportNames[indexPath.row]
            // leaguesVC.selectedSport = sportName // Pass the selected sport name
            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
   


}

