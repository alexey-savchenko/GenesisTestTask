//
//  UIViewController+Extensions.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

extension UIViewController {
	func presentError(_ error: Error) {
		let alert = UIAlertController(title: "Error",
																	message: error.localizedDescription,
																	preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}
