//
//  ViewController.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import UIKit

final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTabs()
    }
    
    
    private func setUpTabs(){
        
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodesViewController()
        let settingVC = RMSettingsViewController()
        
        
       
       
        let navCharacter = UINavigationController(rootViewController: characterVC)
        let navLocation = UINavigationController(rootViewController: locationVC)
        let navEpisode = UINavigationController(rootViewController: episodeVC)
        let navSetting = UINavigationController(rootViewController: settingVC)
        
        navCharacter.tabBarItem =
        UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        navLocation.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        navEpisode.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        navSetting.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        for nav in [navCharacter,navSetting,navEpisode,navLocation]{
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        setViewControllers([navCharacter,navLocation,navEpisode,navSetting], animated: true)
    }


}

