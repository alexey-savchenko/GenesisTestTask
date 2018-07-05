//
//  AppDelegate.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var appCoordinator: CoordinatorType!
	
	func application(_ application: UIApplication,
									 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		appCoordinator = RepoSearchModuleCoordinator(window!)
		appCoordinator.start()
		
		return true
	}
}
