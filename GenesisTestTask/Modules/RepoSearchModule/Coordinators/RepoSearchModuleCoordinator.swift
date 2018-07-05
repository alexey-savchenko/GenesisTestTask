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
    let repoSearchControllerViewModel = RepoSearchControllerViewModel()
    let repoSearchController = RepoSearchController.create(with: repoSearchControllerViewModel)
    navigationController.setViewControllers([repoSearchController], animated: false)
    window.rootViewController = rootController
    window.makeKeyAndVisible()
  }
}
