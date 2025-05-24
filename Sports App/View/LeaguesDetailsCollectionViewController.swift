//
//  LeaguesDetailsCollectionViewController.swift
//  Sports App
//
//  Created by Rokaya El Shahed on 31/01/2025.
//

import UIKit
import SDWebImage

//private let reuseIdentifier = "Cell"
protocol LeaguesDetailsView {
    func showLeagueDetails(upcomingEvents: [Fixture])
    func showLeagueDetails2( latestResults: [Fixture])
    func showTeams(teams: [Team])

}

class LeaguesDetailsCollectionViewController: UICollectionViewController,LeaguesDetailsView ,UICollectionViewDelegateFlowLayout {
   
    var league : LeagueCore?
    var upcomingEvents: [Fixture] = []
    var latestResults: [Fixture] = []
    var teams: [Team] = []
    var leagueKey : Int?
    var sportType : String?
    var presenter = LeagueDetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Leagues"
    //    let presenter = LeagueDetailsPresenter()
        print("key: \(leagueKey ?? 0)  sport: \(sportType ?? "nil")")
       
        setupCollectionView()
        presenter.attachView(view: self)
        if let key = leagueKey, let sport = sportType {
            print("key: \(key)  sport: \(sport)")
            presenter.getLeagueDetails(sport:sport, leagueKey: key)
            presenter.getTeams(leagueKey: key, sport: sport)
        }else {
            print("leagueKey or sportType is nil!")
        }
        setupNavbar()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")

        // Do any additional setup after loading the view.
    }
    func showLeagueDetails(upcomingEvents: [Fixture]) {
        self.upcomingEvents = upcomingEvents
            DispatchQueue.main.async {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.reloadData()
            }
    }
    func showLeagueDetails2( latestResults: [Fixture]) {
            self.latestResults = latestResults
            DispatchQueue.main.async {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.reloadData()
            }
    }
    func showTeams(teams: [Team]) {
        self.teams = teams
        DispatchQueue.main.async {
//            print("Teams count: \(self.teams.count)")
//            
//            for team in teams {
//                print("Team: \(team.team_name ?? "No Name") - Logo: \(team.team_logo ?? "No Logo")")
//                }
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
        }
    }
    var isFavorite = false
    func setupNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
               style: .plain,
               target: self,
               action: #selector(toggleFavorite))
    }
    @objc func toggleFavorite() {
        isFavorite.toggle()

            if let button = navigationItem.rightBarButtonItem {
                let newImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
                button.image = newImage
            }
            if isFavorite {
                addToFavorites()
            }
//        else {
//                removeFromFavorites()
//            }
    }
    func addToFavorites() {
        CoreDataManager.shared.saveLeague(league: league!)
        print("Added to favorites") //  Core Data save
    }

//    func removeFromFavorites() {
//        print("Removed from favorites") //Core Data delete
//    }
    func setupCollectionView () {
        navigationController?.isToolbarHidden = false
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment  in
            if sectionIndex == 0 {
                    return self.drawFirstSection()
                } else if sectionIndex == 1{
                    return self.drawSecondSection()
                }else{
                    return self.drawThirdSection()
                }
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
             flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
             flowLayout.minimumInteritemSpacing = 0
             flowLayout.minimumLineSpacing = 0
         }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60) // Adjust height as needed
    }
    func drawFirstSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//        return section
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
        
    }
    func drawSecondSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//       
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
//
//        return section
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
//
    }
    func drawThirdSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//        return section
//        ****************************
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension:  .absolute(UIScreen.main.bounds.height/6))
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
        //********************
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
//        
//        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
//            items.forEach { item in
//                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                let minScale: CGFloat = 0.8
//                let maxScale: CGFloat = 1.0
//                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                item.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)) // Set the header size
//        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        
//        section.boundarySupplementaryItems = [headerSupplementary]
//        
//        return section
//        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0: return upcomingEvents.count
        case 1: return latestResults.count
        default:
            return teams.count
        }
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! EventsCollectionViewCell
            cell.backgroundColor = UIColor.lightGray
            let event = upcomingEvents[indexPath.row]
            cell.awayTeamLabel.text = event.event_away_team
            cell.homeTeamLabel.text = event.event_home_team
            cell.eventDateLabel.text = event.event_date
            cell.eventTimeLabel.text = event.event_time
            
            if let logo = event.away_team_logo, let awayTeamLogoURL = URL(string: event.away_team_logo ?? " "){
                cell.awayTeamLogo?.sd_setImage(with: awayTeamLogoURL, placeholderImage: UIImage(named: "test"))
            }else{
                cell.awayTeamLogo.image = UIImage(named: "test")
            }
            
            
            let homeTeamLogoURL = URL(string: event.home_team_logo!)
            cell.homeTeamLogo?.sd_setImage(with: homeTeamLogoURL, placeholderImage: UIImage(named: "test"))
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! EventsCollectionViewCell
            // as! ResultsCollectionViewCell
            cell.backgroundColor = UIColor.lightGray
            let event = latestResults[indexPath.row]
            cell.awayTeamLabel.text = event.event_away_team ?? "unknown"
            cell.homeTeamLabel.text = event.event_home_team ?? "unknown"
            cell.eventDateLabel.text = event.event_date ?? "unknown"
            cell.eventTimeLabel.text = event.event_time ?? "unknown"
            cell.eventResultLabel.text = event.event_ft_result
            if let logo = event.away_team_logo, let awayTeamLogoURL = URL(string: event.away_team_logo ?? " "){
                cell.awayTeamLogo?.sd_setImage(with: awayTeamLogoURL, placeholderImage: UIImage(named: "test"))
            }else{
                cell.awayTeamLogo.image = UIImage(named: "test")
            }
            
            
            let homeTeamLogoURL = URL(string: event.home_team_logo!)
            cell.homeTeamLogo?.sd_setImage(with: homeTeamLogoURL, placeholderImage: UIImage(named: "test"))
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TeamsCollectionViewCell
            let team = teams[indexPath.row]
            cell.backgroundColor = UIColor.lightGray
            cell.teamName.text = team.team_name
//            print("Team name: \(team.team_name ?? "No Name")")
//            print("Team logo URL: \(team.team_logo ?? "No Logo")")

            if let logo = team.team_logo, let teamLogoURL = URL(string: team.team_logo ?? " "){
                cell.teamLogo?.sd_setImage(with: teamLogoURL, placeholderImage: UIImage(named: "test"))
            }
            return cell
        }
        // Configure the cell
        
        }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            
            teamDetails.sport = sportType
            teamDetails.team = teams[indexPath.row]
            navigationController?.pushViewController(teamDetails, animated: true)

           // present(teamDetails, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! CollectionReusableView
        headerView.sizeToFit()
        switch indexPath.section {
            case 0: headerView.titleLabel.text = "Upcoming Matches"
            case 1: headerView.titleLabel.text = "Latest Results"
            case 2: headerView.titleLabel.text = "Teams"
            default: headerView.titleLabel.text = "Section \(indexPath.section + 1)"
        }
        headerView.sizeToFit()
        return headerView
    }
  

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
