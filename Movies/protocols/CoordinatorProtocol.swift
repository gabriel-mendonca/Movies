//
//  CoordinatorProtocol.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

/// Protocolo adicional para melhorias de coordinators (não conflita com o existente)
protocol CoordinatorLifecycle {
    var childCoordinators: [AnyObject] { get set }
    
    func addChildCoordinator(_ coordinator: AnyObject)
    func removeChildCoordinator(_ coordinator: AnyObject)
}

extension CoordinatorLifecycle {
    mutating func addChildCoordinator(_ coordinator: AnyObject) {
        childCoordinators.append(coordinator)
    }
    
    mutating func removeChildCoordinator(_ coordinator: AnyObject) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
