//
//  AppCoordinator.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class AppCoodinator: CoordinatorType {
	
	// MARK: - Properties
	
	var childCoordinators = [CoordinatorType]()
	
	var rootController: UIViewController {
		return navigationController
	}
	
	private let navigationController = UINavigationController()
	private let window: UIWindow
	
	// MARK: - Init and deinit
	
	init(_ window: UIWindow) {
		self.window = window
	}
	deinit {
		print("\(self) dealloc")
	}
	
	// MARK: - Functions
	
	func start() {
		let repoSearchCoordinator = RepoSearchModuleCoordinator(self)
		addChildCoordinator(repoSearchCoordinator)
		repoSearchCoordinator.start()
		window.rootViewController = rootController
		window.makeKeyAndVisible()
		rootController.present(repoSearchCoordinator.rootController, animated: false)
	}
}

protocol RepoSearchModuleCoordinatorDelegate: class {
	func showSearchHistory()
}

protocol SearchHistoryModuleCoordinatorDelegate: class {
	func dissmisFlow(_ coordinator: CoordinatorType)
}

extension AppCoodinator: RepoSearchModuleCoordinatorDelegate {
	func showSearchHistory() {
		let searchHistoryCoordinator = SearchHistoryModuleCoordinator(self)
		addChildCoordinator(searchHistoryCoordinator)
		searchHistoryCoordinator.start()
		window.rootViewController?.presentedViewController?.present(searchHistoryCoordinator.rootController, animated: true)
	}
}

extension AppCoodinator: SearchHistoryModuleCoordinatorDelegate {
	func dissmisFlow(_ coordinator: CoordinatorType) {
		coordinator.rootController.dismiss(animated: true)
		removeChildCoordinator(coordinator)
	}
}
