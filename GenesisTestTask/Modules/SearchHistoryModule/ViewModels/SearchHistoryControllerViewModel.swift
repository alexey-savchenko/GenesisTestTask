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
	let input: Input
	let output: Output
	
	private let historyItemSelectedSubject = PublishSubject<SearchHistoryItemTableViewCellViewModel>()
	private let dissmisSubject = PublishSubject<Void>()
	private weak var navigationDelegate: SearchHistoryModuleNavigationDelegate?
	private let disposeBag = DisposeBag()
	
	struct Input {
		let historyItemSelected: AnyObserver<SearchHistoryItemTableViewCellViewModel>
		let dissmis: AnyObserver<Void>
	}
	
	struct Output {
		let searchHistory: Observable<[SearchHistoryItemTableViewCellViewModel]>
	}
	
	init(_ historyInfoProvider: SearchHistoryInfoProviderProtocol = CoreDataStack.shared,
			 navigationDelegate: SearchHistoryModuleNavigationDelegate) {
		
		input = Input(historyItemSelected: historyItemSelectedSubject.asObserver(),
									dissmis: dissmisSubject.asObserver())
		
		output = Output(searchHistory: historyInfoProvider.historyItems.map({ (historyItems) in
			historyItems.map(SearchHistoryItemTableViewCellViewModel.init)
		}))
		
		historyItemSelectedSubject
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
}
