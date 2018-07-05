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
	
	// Outputs
	
	
  struct Input {
		let searchQuery: AnyObserver<String>
		let cancelQuery: AnyObserver<Void>
  }
	
  struct Output {
		let repos: Observable<[RepoListTableViewCellViewModel]>
  }
  
  // MARK: - Init and deinit
	init(_ repoFetchService: RepoFetchServiceProtocol = MockFetchService()) {
		
		self.repoFetchService = repoFetchService
		
		input = Input(searchQuery: searchQuerySubject.asObserver(),
									cancelQuery: cancelSearchSubject.asObserver())
		output = Output(repos: self.repoFetchService.searchRepos(using: "Test").map({ (infos) in
			infos.map(RepoListTableViewCellViewModel.init)
		}))
		
		self.repoFetchService
			.searchRepos(using: "Test")
			.subscribe(onNext: { (repos) in
				print(repos)
			})
			.disposed(by: disposeBag)
  }
  deinit {
    print("\(self) dealloc")
  }
}
