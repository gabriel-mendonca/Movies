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
}
