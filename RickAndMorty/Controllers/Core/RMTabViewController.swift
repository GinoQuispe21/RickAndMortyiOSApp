//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 20/08/23.
//

import UIKit

/// Controller to house tabs and root tab controllers
class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    private func setUpTabs() {
        // View Controllers
        let characterViewController = RMCharacterViewController()
        let locationViewController = RMLocationViewController()
        let episodeViewController = RMEpisodeViewController()
        let settingsViewContorller = RMSettingsViewController()
        // Title size
        characterViewController.navigationItem.largeTitleDisplayMode = .automatic
        locationViewController.navigationItem.largeTitleDisplayMode = .automatic
        episodeViewController.navigationItem.largeTitleDisplayMode = .automatic
        settingsViewContorller.navigationItem.largeTitleDisplayMode = .automatic
        // Navigation Controllers
        let navCharacters = UINavigationController(rootViewController: characterViewController)
        navCharacters.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 1)
        let navLocation = UINavigationController(rootViewController: locationViewController)
        navLocation.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe"), tag: 2)
        let navEpisode = UINavigationController(rootViewController: episodeViewController)
        navEpisode.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        let navSettings = UINavigationController(rootViewController: settingsViewContorller)
        navSettings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        //  Navigation Array
        let tabs = [navCharacters, navLocation, navEpisode, navSettings]
        for nav in tabs {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers(tabs, animated: true)
    }

}

