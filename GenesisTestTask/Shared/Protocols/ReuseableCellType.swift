//
//  ReuseableCellType.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol ReusableCellType: class {
	associatedtype CellViewModel: ViewModelType
	static var reuseIdentifier: String { get }
	func fill(with cellViewModel: CellViewModel)
}

extension ReusableCellType {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}
