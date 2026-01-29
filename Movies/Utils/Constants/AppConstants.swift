//
//  AppConstants.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

/// Constantes da aplicação para evitar valores mágicos
enum AppConstants {
    
    enum UI {
        static let defaultCornerRadius: CGFloat = 8.0
        static let posterCornerRadiusDivisor: CGFloat = 12.5
        static let defaultSpacing: CGFloat = 10.0
        static let largeSpacing: CGFloat = 20.0
        static let headerHeight: CGFloat = 320.0
        static let movieRowHeight: CGFloat = 250.0
        static let posterWidth: CGFloat = 126.0
        static let posterHeight: CGFloat = 187.0
    }
    
    enum CollectionView {
        static let horizontalInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 0)
        static let verticalInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    enum Colors {
        static let backgroundColor = UIColor.black
        static let textColor = UIColor.white
    }
    
    enum ReuseIdentifiers {
        static let movieTableViewCell = "MovieTableViewCell"
        static let movieCollectionViewCell = "MovieCollectionViewCell"
        static let searchCollectionViewCell = "SearchCollectionViewCell"
    }
    
    enum Service {
        static let authToken = "Bearer 'HERE YOUR AUTHORIZATION'"
        static let baseURL = "https://api.themoviedb.org/3"
    }
}
