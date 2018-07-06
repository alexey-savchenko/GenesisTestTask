//
//  SearchHistoryItemTableViewCellViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

class SearchHistoryItemTableViewCellViewModel: ViewModelType {
	let input: Input
	let output: Output
	
	private let historyItem: SearchHistoryItem
	
	struct Input {
	}
	struct Output {
		let historyItem: SearchHistoryItem
		let searchQueryString: String
		let searchDateString: String
	}
	
	init(_ historyItem: SearchHistoryItem) {
		self.historyItem = historyItem
		input = Input()
		
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		let searchDateString = formatter.string(from: historyItem.searchDate!)
		
		output = Output(historyItem: historyItem,
										searchQueryString: historyItem.searchQuery ?? "",
										searchDateString: searchDateString)
	}
}
