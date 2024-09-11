//
//  AppCoordinator.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

import UIKit

/**
 ## AppCoordinator
 
 This is a AppCoordinator class which provide feature of various navigation.
 
 */

@objcMembers public class AppCoordinator: NSObject, Coordinator {
    
    /// MARK: - Properties
    
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    
    /// MARK: - Life Cycle
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// MARK: - Presenters
    
    public func begin() {
        showHomeViewController()
        self.addCoordinator(self)
    }
    
    public func showHomeViewController() {
        let vehicleListVC = VehicleListViewController()
        navigationController.pushViewController(vehicleListVC, animated: true)
    }
    
    public func showMapViewController() {
        let mapViewController = MapViewController()
        UIView.transition(with: (self.navigationController.view)!, duration: 0.75, options: .transitionFlipFromRight, animations: {
            self.navigationController.pushViewController(mapViewController, animated: false)
        })
    }
    
    public func backViewControllerWithFlipLeft() {
        UIView.transition(with: (self.navigationController.view)!, duration: 0.75, options: .transitionFlipFromLeft, animations: {
            self.navigationController.popViewController(animated: false)
        })
        
    }
    
    
}

