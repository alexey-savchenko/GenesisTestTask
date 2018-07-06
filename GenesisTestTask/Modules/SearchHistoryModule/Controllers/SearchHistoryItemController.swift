//
//  SearchHistoryItemController.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchHistoryItemController: UIViewController, ControllerType, RepoWebPresenter {
	
	// MARK: - Properties
	
	typealias ViewModel = SearchHistoryItemControllerViewModel
	var viewModel: SearchHistoryItemControllerViewModel!
	private let disposeBag = DisposeBag()
	
	// MARK: - UI
	
	@IBOutlet weak var searchResultsTableView: UITableView!
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTableView()
		configure(with: viewModel)
	}
	
	// MARK: - Functions
	
	func configure(with viewModel: SearchHistoryItemControllerViewModel) {
		navigationItem.title = viewModel.output.title
		
		viewModel.output.repositoryCellViewModels
			.bind(to: searchResultsTableView.rx
				.items(cellIdentifier: RepoListTableViewCell.reuseIdentifier)) { row, element, cell in
					if let cell = cell as? RepoListTableViewCell {
						cell.fill(with: element)
					}
		}.disposed(by: disposeBag)
	}
	
	private func configureTableView() {
		searchResultsTableView.estimatedRowHeight = 100
		searchResultsTableView.rowHeight = UITableViewAutomaticDimension
		searchResultsTableView.registerReuseableCell(RepoListTableViewCell.self)
	}
}

