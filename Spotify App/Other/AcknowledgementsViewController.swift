//
//  acknowledgementsViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 10/6/2022.
//

import UIKit

struct AcknowledgementCell {
    let locationLabel: String
    let useLabel: String
    let urlLabel: String
}

class AcknowledgementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var acknowledgementsArray: [AcknowledgementCell] = []

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero  , style: .plain)
        tableView.register(AcknowledgementsTableViewCell.self, forCellReuseIdentifier: AcknowledgementsTableViewCell.identifier)
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "StorageUITableViewController",
            useLabel: "Used to determine how to create table views programatically",
            urlLabel: "https://www.youtube.com/watch?v=2yVzeFIMtyc&ab_channel=iOSAcademy"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel:"AppDelegate, SceneDelegate, WelcomeViewController",
            useLabel: "Used to create the token key and login setup for the Spotify SDK",
            urlLabel: "https://www.youtube.com/watch?v=MfhwNT5uT2s&list=PL5PR3UyfTWve9ZC7Yws0x6EGjBO2FGr0o&index=3&ab_channel=iOSAcademy"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "PlayerViewController, StorageTableViewController",
            useLabel: "Used to save songs into Core Data",
            urlLabel: "https://www.youtube.com/watch?v=O7u9nYWjvKk&ab_channel=CodeWithChris"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "StorageUITableViewController",
            useLabel: "Used to see how to delete rows in tables",
            urlLabel: "https://stackoverflow.com/questions/40156274/deleting-a-row-from-a-uitableview-in-swift"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "PlaybackPresenter",
            useLabel: "To play music from the spotify sdk",
            urlLabel: "https://www.youtube.com/watch?v=e2-EGeCNs34&list=PL5PR3UyfTWve9ZC7Yws0x6EGjBO2FGr0o&index=20&ab_channel=iOSAcademy"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "PlayerViewController",
            useLabel: "To use swipe gestures",
            urlLabel: "https://www.youtube.com/watch?v=r5emjIgmFB8&ab_channel=iOSAcademy"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "APICaller, HomeScreenViewController, SearchViewController, SearchResultsViewController",
            useLabel: "To create API Calls using the Spotify SDK",
            urlLabel: "https://developer.spotify.com/documentation/web-api/reference/#/"))
        acknowledgementsArray.append(AcknowledgementCell(
            locationLabel: "HomeScreenViewController",
            useLabel: "To create collection Views to present data",
            urlLabel: "https://developer.spotify.com/documentation/web-api/reference/#/"))
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acknowledgementsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcknowledgementsTableViewCell.identifier, for: indexPath) as? AcknowledgementsTableViewCell else {
            return UITableViewCell()
        }
            let viewModel = AcknowledgementsTableViewCellViewModel(
                locationLabel: "Location: " + acknowledgementsArray[indexPath.row].locationLabel,
                useLabel: "Use Case: " + acknowledgementsArray[indexPath.row].useLabel,
                urlLabel:"URL: " + acknowledgementsArray[indexPath.row].urlLabel)
            cell.configure(with: viewModel)
            return cell
            
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150    }
        

}
