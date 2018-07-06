//
//  RepoWebPresenter.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

protocol RepoWebPresenter {
	func presentRepoWebPage(_ repoURL: URL)
}

extension RepoWebPresenter where Self: UIViewController {
	func presentRepoWebPage(_ repoURL: URL) {
		
	}
}
