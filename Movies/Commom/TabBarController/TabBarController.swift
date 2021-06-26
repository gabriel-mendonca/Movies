//
//  TabBarController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .ColorDarkBlueDefault
        self.tabBar.unselectedItemTintColor = .ColorGrayDefault
        self.tabBar.tintColor = .white
        
    }
    
//    func setupTabBar() {
//
//        let movieController = UINavigationController(rootViewController: MovieViewController())
//        movieController.tabBarItem.image = UIImage(systemName: "film")
//        movieController.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
//        movieController.setNavigationBarHidden(true, animated: false)
//        movieController.tabBarItem.title = "Filmes"
//
//        let serieController = UINavigationController(rootViewController: SerieViewController())
//        serieController.tabBarItem.image = UIImage(systemName: "tv")
//        serieController.tabBarItem.selectedImage = UIImage(systemName: "tv.fill")
//        serieController.setNavigationBarHidden(true, animated: false)
//        serieController.tabBarItem.title = "Séries"
//
//        let searchController = UINavigationController(rootViewController: SearchViewController())
//        searchController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
//        searchController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
//        searchController.setNavigationBarHidden(true, animated: false)
//        searchController.tabBarItem.title = "Search"
//
//        self.viewControllers = [movieController,serieController,searchController]
//
//    }
    
}
