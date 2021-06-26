//
//  BaseCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

enum PresentationType {
    case modal(viewController: UIViewController)
    case push(navigation: NavigationController)
    
    public func associatedValue() -> Any? {
        switch self {
        case .modal(let value):
            return value
        case .push(let value):
            return value
        }
    }
}


protocol Coordinator: AnyObject {
    associatedtype V: UIViewController
    var view: V? {get set}
    var navigation: NavigationController? {get set}
    func start() -> V
    func start(usingPresentation presentation: PresentationType)
    func stop()
}

extension Coordinator {
    func start() -> V {
        if let view = view {
            return view
        }
        fatalError("You cannot start coordinator without initializing property view!")
    }
    
    func start(usingPresentation presentation: PresentationType) {
        switch presentation {
        case .modal(let controller):
            self.navigation = NavigationController(rootViewController: start())
            guard let nav = self.navigation else { return }
            controller.present(nav, animated: true, completion: nil)
        case .push(let navigation):
            self.navigation = navigation
            navigation.pushViewController(start(), animated: true)
        }
    }
}
