//
//  CoordinatorType.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

protocol CoordinatorType: class {
    var childCoordinators: [CoordinatorType] { get set }
    var rootController: UIViewController { get }
    
    func start()
}

extension CoordinatorType {
    public func addChildCoordinator(_ childCoordinator: CoordinatorType) {
        self.childCoordinators.append(childCoordinator)
    }
    
    public func removeChildCoordinator(_ childCoordinator: CoordinatorType) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
