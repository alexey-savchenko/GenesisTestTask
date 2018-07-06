//
//  SearchHistoryController.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchHistoryController: UIViewController, ControllerType {
	
	// MARK: - Properties
	typealias ViewModel = SearchHistoryControllerViewModel
	
	var viewModel: SearchHistoryControllerViewModel!
	private let disposeBag = DisposeBag()
	
	// MARK: - UI
	
	@IBOutlet weak var historyItemsTableView: UITableView!
	private let dissmisBarItem = UIBarButtonItem(title: "Dissmis", style: .plain, target: nil, action: nil)
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureUI()
		configure(with: viewModel)
	}
	
	// MARK: - Functions
	
	func configure(with viewModel: SearchHistoryControllerViewModel) {
		dissmisBarItem.rx.tap
			.subscribe(viewModel.input.dissmis)
			.disposed(by: disposeBag)
		
		historyItemsTableView.rx.modelSelected(SearchHistoryItemTableViewCellViewModel.self)
			.do(onNext: { [unowned self] _ in
				self.historyItemsTableView.indexPathsForSelectedRows?.forEach({ (idx) in
					self.historyItemsTableView.deselectRow(at: idx, animated: true)
				})
			}).debug()
			.subscribe(viewModel.input.historyItemSelected)
			.disposed(by: disposeBag)
		
		viewModel.output.searchHistory
			.bind(to: historyItemsTableView.rx
				.items(cellIdentifier: SearchHistoryItemTableViewCell.reuseIdentifier))
			{ row, element, cell in
				
				if let cell = cell as? SearchHistoryItemTableViewCell {
					cell.fill(with: element)
				}
				
			}.disposed(by: disposeBag)
	}
	
	private func configureTableView() {
		historyItemsTableView.estimatedRowHeight = 100
		historyItemsTableView.keyboardDismissMode = .interactive
		historyItemsTableView.rowHeight = UITableViewAutomaticDimension
		historyItemsTableView.registerReuseableCell(SearchHistoryItemTableViewCell.self)
	}
	
	private func configureUI() {
		configureTableView()
		navigationItem.title = "Search history"
		navigationItem.leftBarButtonItems = [dissmisBarItem]
	}
	
	deinit {
		print("\(self) dealloc")
	}
}
