//
//  RepoSearchControllerViewModel.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

class RepoSearchControllerViewModel: ViewModelType {
	
	// MARK: - Public Properties
	
	let input: Input
	let output: Output
	
	// MARK: - Private Properties
	
	private let repoFetchService: RepoFetchServiceProtocol
	private let disposeBag = DisposeBag()
	
	// Inputs
	private let searchQuerySubject = PublishSubject<String>()
	private let cancelSearchSubject = PublishSubject<Void>()
	private let startSearchSubject = PublishSubject<Void>()
	
	// Outputs
	private let isQueryingSubject = BehaviorSubject<Bool>(value: false)
	private let reposSubject = PublishSubject<[RepoListTableViewCellViewModel]>()
	private let errorsSubject = PublishSubject<Error>()
	
	struct Input {
		let searchQuery: AnyObserver<String>
		let startSearch: AnyObserver<Void>
		let cancelSearch: AnyObserver<Void>
	}
	
	struct Output {
		let repos: Observable<[RepoListTableViewCellViewModel]>
		let errors: Observable<Error>
		let isQuerying: Observable<Bool>
	}
	
	// MARK: - Init and deinit
	init(_ repoFetchService: RepoFetchServiceProtocol = RepoFetchService()) {
		
		self.repoFetchService = repoFetchService
		
		input = Input(searchQuery: searchQuerySubject.asObserver(),
									startSearch: startSearchSubject.asObserver(),
									cancelSearch: cancelSearchSubject.asObserver())
		
		output = Output(repos: reposSubject.asObservable(),
										errors: errorsSubject.asObservable(),
										isQuerying: isQueryingSubject.asObservable())
		
		bindViewModelToService()
	}
	
	private func bindViewModelToService() {
		repoFetchService.isQuerying.debug()
			.subscribe(isQueryingSubject)
			.disposed(by: disposeBag)
		
		cancelSearchSubject
			.subscribe(onNext: { [unowned self] _ in
				self.repoFetchService.cancelQuery()
			})
			.disposed(by: disposeBag)
		
		startSearchSubject
			.withLatestFrom(searchQuerySubject).debug()
			.distinctUntilChanged()
			.flatMapLatest{ [unowned self] (query) in
				self.repoFetchService.searchRepos(using: query).materialize()
			}.subscribe(onNext: { [unowned self] event in
				switch event {
				case .next(let value):
					let cellViewModels = value.map(RepoListTableViewCellViewModel.init)
					self.reposSubject.onNext(cellViewModels)
				case .error(let error):
					self.errorsSubject.onNext(error)
				default:
					break
				}
			}).disposed(by: disposeBag)
	}
	
	deinit {
		print("\(self) dealloc")
	}
}
