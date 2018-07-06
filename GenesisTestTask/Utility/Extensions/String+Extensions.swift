//
//  String+Extensions.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

extension String {
	func trunc(length: Int, trailing: String = "…") -> String {
		return (self.count > length) ? self.prefix(length) + trailing : self
	}
}
