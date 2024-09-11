//
//  Coordinator.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

import UIKit

/**
 ## Coordinator
 
 This protocol provides methods for navigations.
 
 */

@objc(Coordinator)
public protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func begin()
    func showHomeViewController()
    func showMapViewController()
    func backViewControllerWithFlipLeft()
}

extension Coordinator {
    func addCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func removeAllCoordinators() {
        childCoordinators.removeAll()
    }
}
