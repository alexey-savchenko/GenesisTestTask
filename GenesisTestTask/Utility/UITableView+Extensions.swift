//
//  UITableView+Extensions.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

extension UITableView {
	func registerReuseableCell<C: ReusableCellType>(_ cell: C.Type) {
		let name = String(describing: cell)
		register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
	}
}
