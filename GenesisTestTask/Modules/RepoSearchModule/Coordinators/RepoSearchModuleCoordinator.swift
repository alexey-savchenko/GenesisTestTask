//
//  RepoSearchModuleCoordinator.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class RepoSearchModuleCoordinator: CoordinatorType {
    var childCoordinators = [CoordinatorType]()
    
    var rootController: UIViewController {
        return navigationController
    }
    
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let repoSearchControllerViewModel = RepoSearchControllerViewModel()
        let repoSearchController = RepoSearchController.create(with: repoSearchControllerViewModel)
        navigationController.setViewControllers([repoSearchController], animated: false)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
}
