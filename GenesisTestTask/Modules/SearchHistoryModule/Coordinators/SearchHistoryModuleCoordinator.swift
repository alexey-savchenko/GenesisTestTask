//
//  SearchHistoryModuleCoordinator.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class SearchHistoryModuleCoordinator: CoordinatorType {
	
	// MARK: - Properties
	
	var childCoordinators = [CoordinatorType]()
	
	var rootController: UIViewController {
		return navigationController
	}
	
	private let navigationController = UINavigationController()
	private weak var coordinatorDelegate: SearchHistoryModuleCoordinatorDelegate?
	
	// MARK: - Init and deinit
	
	init(_ coordinatorDelegate: SearchHistoryModuleCoordinatorDelegate) {
		self.coordinatorDelegate = coordinatorDelegate
	}
	deinit {
		print("\(self) dealloc")
	}
	
	// MARK: - Functions
	
	func start() {
		do {
			let searchHistoryControllerViewModel = SearchHistoryControllerViewModel(navigationDelegate: self)
			let searchHistoryController = try SearchHistoryController.create(with: searchHistoryControllerViewModel)
			navigationController.setViewControllers([searchHistoryController], animated: false)
		} catch {
			// Handle error
			print(error.localizedDescription)
		}
	}
}

protocol SearchHistoryModuleNavigationDelegate: class {
	func showSearchResultsFor(_ historyItem: SearchHistoryItem)
	func dissmisFlow()
}

extension SearchHistoryModuleCoordinator: SearchHistoryModuleNavigationDelegate {
	func dissmisFlow() {
		coordinatorDelegate?.dissmisFlow(self)
	}
	
	func showSearchResultsFor(_ historyItem: SearchHistoryItem) {
		do {
			let searchHistoryItemControllerViewModel = SearchHistoryItemControllerViewModel(historyItem)
			let searchHistoryItemController = try SearchHistoryItemController.create(with: searchHistoryItemControllerViewModel)
			navigationController.pushViewController(searchHistoryItemController, animated: true)
		} catch {
			// Handle error
			print(error.localizedDescription)
		}
	}
}
