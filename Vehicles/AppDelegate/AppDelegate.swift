//
//  AppDelegate.swift
//  Taxi
//
//  Created by Ashish Patel on 2021/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: Coordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let coordinator = AppCoordinator(with: navigationController)
        appCoordinator = coordinator
        window?.rootViewController = appCoordinator?.navigationController
        coordinator.begin()
        window?.makeKeyAndVisible()
        return true
    }

}

