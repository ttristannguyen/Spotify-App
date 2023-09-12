//
//  TabBarViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 4/5/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let viewController1 = HomeScreenViewController()
        let viewController2 = SearchViewController()
        let viewController3 = StorageTableViewController()
//        let viewController4 = SwipeViewController()
        
        viewController1.title = "Browse"
        viewController2.title = "Search"
        viewController3.title = "Library"
//        viewController4.title = "Swipe"
        
        viewController1.navigationItem.largeTitleDisplayMode = .always
        viewController2.navigationItem.largeTitleDisplayMode = .always
        viewController3.navigationItem.largeTitleDisplayMode = .always
//        viewController4.navigationItem.largeTitleDisplayMode = .always
        
        let navigation1 = UINavigationController(rootViewController: viewController1)
        let navigation2 = UINavigationController(rootViewController: viewController2)
        let navigation3 = UINavigationController(rootViewController: viewController3)
//        let navigation4 = UINavigationController(rootViewController: viewController4)
        
        navigation1.navigationBar.tintColor = .label
        navigation2.navigationBar.tintColor = .label
        navigation3.navigationBar.tintColor = .label
//        navigation4.navigationBar.tintColor = .label
        
        navigation1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"),tag:1)
        navigation2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"),tag:1)
        navigation3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"),tag:1)
//        navigation4.tabBarItem = UITabBarItem(title: "Swipe", image: UIImage(systemName: "hand.draw"),tag:1)
        
        
        navigation1.navigationBar.prefersLargeTitles = true
        navigation2.navigationBar.prefersLargeTitles = true
        navigation3.navigationBar.prefersLargeTitles = true
//        navigation4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navigation1,navigation2,navigation3], animated: false)
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
