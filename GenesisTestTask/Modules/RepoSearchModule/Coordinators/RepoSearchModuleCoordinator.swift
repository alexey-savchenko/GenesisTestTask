//
//  RepoSearchModuleCoordinator.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class RepoSearchModuleCoordinator: CoordinatorType {
  
  // MARK: - Properties
  
  var childCoordinators = [CoordinatorType]()
  
  var rootController: UIViewController {
    return navigationController
  }
  
  private let navigationController = UINavigationController()
	private weak var coordinatorDelegate: RepoSearchModuleCoordinatorDelegate?
	
	init(_ coordinatorDelegate: RepoSearchModuleCoordinatorDelegate) {
		self.coordinatorDelegate = coordinatorDelegate
	}
	
  // MARK: - Functions
  
  func start() {
		do {
			let repoSearchControllerViewModel = RepoSearchControllerViewModel(navigationDelegate: self)
			let repoSearchController = try RepoSearchController.create(with: repoSearchControllerViewModel)
			navigationController.setViewControllers([repoSearchController], animated: false)
		} catch {
			// Handle error somehow
			print(error)
		}
	}
}

protocol RepoSearchModuleNavigationDelegate: class {
	func showSearchHistory()
}

extension RepoSearchModuleCoordinator: RepoSearchModuleNavigationDelegate {
	func showSearchHistory() {
		coordinatorDelegate?.showSearchHistory()
	}
}
