//
//  RepoListTableViewCellViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

class RepoListTableViewCellViewModel: ViewModelType {
	
	// MARK: - Public Properties
	
	let input: Input
	let output: Output
	
	struct Input {
	}
	
	struct Output {
		let repoNameString: String
		let starsCountString: String
		let ownerUserpicURL: URL
		let repoLanguageString: String
		let repoURL: URL
	}
	
	// MARK: - Init and deinit
	
	init(_ repoInfo: RepoInfo) {
		input = Input()
		
		let repoNameString = repoInfo.fullName.trunc(length: 30)
		let starCountString = "Stars: \(repoInfo.stargazersCount)"
		let ownerUserpicURL = URL(string: repoInfo.owner.avatarURL)!
		let repoLanguageString = "Language: \(repoInfo.language ?? "-")"
		let repoURL = URL(string: repoInfo.htmlURL)!
		
		output = Output(repoNameString: repoNameString,
										starsCountString: starCountString,
										ownerUserpicURL: ownerUserpicURL,
										repoLanguageString: repoLanguageString,
										repoURL: repoURL)
	}
	deinit {
		print("\(self) dealloc")
	}
}
