//
//  SearchHistoryItemTableViewCell.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

class SearchHistoryItemTableViewCell: UITableViewCell, ReusableCellType {
	
	typealias CellViewModel = SearchHistoryItemTableViewCellViewModel
	@IBOutlet weak var searchQueryLabel: UILabel!
	@IBOutlet weak var searchDateLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func fill(with cellViewModel: SearchHistoryItemTableViewCellViewModel) {
		searchQueryLabel.text = cellViewModel.output.searchQueryString
		searchDateLabel.text = cellViewModel.output.searchDateString
	}
}
