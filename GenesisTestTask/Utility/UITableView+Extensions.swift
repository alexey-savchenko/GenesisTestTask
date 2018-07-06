//
//  UITableView+Extensions.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

extension UITableView {
	func registerReuseableCell<C: ReusableCellType>(_ cellType: C.Type) {
		let typeName = String(describing: cellType)
		register(UINib(nibName: typeName, bundle: nil), forCellReuseIdentifier: typeName)
	}
}
