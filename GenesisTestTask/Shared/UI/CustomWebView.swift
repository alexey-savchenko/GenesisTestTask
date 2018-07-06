//
//  CustomWebView.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class CustomWebView: UIView {
	
	private let background = UIView()
	private let webView = UIWebView()
	private let dissmisButton = UIButton()
	
	func load(_ url: URL) {
		webView.loadRequest(URLRequest(url: url))
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		background.backgroundColor = .black
		background.layer.opacity = 0.3
		addSubview(background)
		background.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([background.trailingAnchor.constraint(equalTo: trailingAnchor),
																 background.leadingAnchor.constraint(equalTo: leadingAnchor),
																 background.topAnchor.constraint(equalTo: topAnchor),
																 background.bottomAnchor.constraint(equalTo: bottomAnchor)])
		
		addSubview(webView)
		webView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([webView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
																 webView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
																 webView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
																 webView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)])
		
		addSubview(dissmisButton)
		dissmisButton.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
		dissmisButton.setBackgroundImage(#imageLiteral(resourceName: "dissmis"), for: .normal)
		dissmisButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([dissmisButton.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 20),
																 dissmisButton.topAnchor.constraint(equalTo: webView.topAnchor, constant: -20),
																 dissmisButton.widthAnchor.constraint(equalToConstant: 40),
																 dissmisButton.heightAnchor.constraint(equalToConstant: 40)])

	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func dissmis() {
		removeFromSuperview()
	}
	
	deinit {
		print("\(self) dealloc")
	}
}
