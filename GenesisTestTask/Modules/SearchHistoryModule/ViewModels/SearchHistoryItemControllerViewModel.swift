//
//  SearchHistoryItemControllerViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

class SearchHistoryItemControllerViewModel: ViewModelType {
	
	// MARK: - Public properties
	let input: Input
	let output: Output
	
	struct Input {
	}
	
	struct Output {
		let title: String
		let repositoryCellViewModels: Observable<[RepoListTableViewCellViewModel]>
	}
	
	// MARK: - Init and deinit
	init(_ searchHistoryItem: SearchHistoryItem) {
		input = Input()
		
		var repositoryCellViewModels = [RepoListTableViewCellViewModel]()
		
		if let searchResultsData = searchHistoryItem.searchResults,
			let reposInfo = try? JSONDecoder().decode([RepoInfo].self, from: searchResultsData) {
			
			repositoryCellViewModels = reposInfo.map(RepoListTableViewCellViewModel.init)
		}
		
		output = Output(title: searchHistoryItem.searchQuery ?? "",
										repositoryCellViewModels: Observable.just(repositoryCellViewModels))
	}
	
	deinit {
		print("\(self) dealloc")
	}
}
