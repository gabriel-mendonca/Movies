//
//  TabBarCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var window: UIWindow
    var view: TabBarController?
    var navigation: NavigationController?
    
    var movie: MovieCoordinator!
    var serie: SerieCoordinator!
    var search: SearchCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        movie = MovieCoordinator()
        serie = SerieCoordinator()
        search = SearchCoordinator()
        view = TabBarController()
        
    }
    
    func configTabBar() -> UITabBarController {
        // Configure coordinaotes
        window.rootViewController = view
        movie.start(usingPresentation: .push(navigation: NavigationController()))
        serie.start(usingPresentation: .push(navigation: NavigationController()))
        search.start(usingPresentation: .push(navigation: NavigationController()))
        view?.viewControllers = [movie.navigation!, serie.navigation!, search.navigation!]
        view?.tabBar.items?[0].title = "Filmes"
        view?.tabBar.items?[0].image = UIImage(systemName: "film")
        view?.tabBar.items?[0].selectedImage = UIImage(systemName: "film.fill")
        
        view?.tabBar.items?[1].title = "Séries"
        view?.tabBar.items?[1].image = UIImage(systemName: "tv")
        view?.tabBar.items?[1].selectedImage = UIImage(systemName: "tv.fill")
        
        view?.tabBar.items?[2].title = "Procurar"
        view?.tabBar.items?[2].image = UIImage(systemName: "magnifyingglass")
        view?.tabBar.items?[2].selectedImage = UIImage(systemName: "magnifyingglass")
        
        return view!
    }
    
    
    
    func stop() {
        
    }
    
        
}
