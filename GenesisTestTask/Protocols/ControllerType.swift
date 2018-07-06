//
//  ControllerType.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

protocol ControllerType: class {
  associatedtype ViewModel: ViewModelType
  var viewModel: ViewModel! { get set }
  /// Configurates controller with specified CPViewModel subclass
  ///
  /// - Parameter viewModel: CPViewModel subclass instance to configure with
  func configure(with viewModel: ViewModel)
  /// Factory function for view controller instatiation
  ///
  /// - Parameter viewModel: View model object
  /// - Returns: View controller of concrete type
  static func create(with viewModel: ViewModel) throws -> UIViewController
}

extension ControllerType {
  static func create(with viewModel: ViewModel) throws -> UIViewController {
    let typeName = String(describing: self)
    let storyboard = UIStoryboard(name: typeName, bundle: nil)
		if let controller = storyboard.instantiateViewController(withIdentifier: typeName) as? Self {
			controller.viewModel = viewModel
			return controller as! UIViewController
		} else {
			throw "Cannot instantiate ViewController instance \(typeName) from storyboard with name \(typeName)!"
		}
	}
}
