//
//  SearchHistoryControllerViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

class SearchHistoryControllerViewModel: ViewModelType {
	
	// MARK: - Public properties
	
	let input: Input
	let output: Output
	
	// MARK: - Private properties
	
	private weak var navigationDelegate: SearchHistoryModuleNavigationDelegate?
	private let disposeBag = DisposeBag()
	
	// Inputs
	private let historyItemSelectedSubject = PublishSubject<SearchHistoryItemTableViewCellViewModel>()
	private let dissmisSubject = PublishSubject<Void>()
	
	struct Input {
		let historyItemSelected: AnyObserver<SearchHistoryItemTableViewCellViewModel>
		let dissmis: AnyObserver<Void>
	}
	
	struct Output {
		let searchHistory: Observable<[SearchHistoryItemTableViewCellViewModel]>
	}
	
	// MARK: - Init and deinit
	
	init(_ historyInfoProvider: SearchHistoryInfoProviderProtocol = CoreDataStack.shared,
			 navigationDelegate: SearchHistoryModuleNavigationDelegate) {
		
		self.navigationDelegate = navigationDelegate
		
		input = Input(historyItemSelected: historyItemSelectedSubject.asObserver(),
									dissmis: dissmisSubject.asObserver())
		
		output = Output(searchHistory: historyInfoProvider.historyItems.map({ (historyItems) in
			historyItems.map(SearchHistoryItemTableViewCellViewModel.init)
		}))
		
		historyItemSelectedSubject.debug()
			.subscribe(onNext: { [unowned self] (historyItem) in
				self.navigationDelegate?.showSearchResultsFor(historyItem.output.historyItem)
			})
			.disposed(by: disposeBag)
		
		dissmisSubject
			.subscribe(onNext: { [unowned self] _ in
				self.navigationDelegate?.dissmisFlow()
			})
			.disposed(by: disposeBag)
	}
	
	deinit {
		print("\(self) dealloc")
	}
}
