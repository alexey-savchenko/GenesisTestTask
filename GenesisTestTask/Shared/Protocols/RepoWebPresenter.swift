//
//  RepoWebPresenter.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import WebKit

protocol RepoWebPresenter {
	func presentRepoWebPage(_ repoURL: URL)
}

extension RepoWebPresenter where Self: UIViewController {
	func presentRepoWebPage(_ repoURL: URL) {
		let webView = CustomWebView(frame: view.frame)
		view.addSubview(webView)
		webView.load(repoURL)
	}
}
