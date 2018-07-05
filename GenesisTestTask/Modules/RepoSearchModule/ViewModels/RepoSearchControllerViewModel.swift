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
  
  // MARK: - Properties
  
  let input: Input
  let output: Output
	
	// Inputs
	private let searchQuerySubject = PublishSubject<String>()
	private let cancelSearchSubject = PublishSubject<Void>()
	
	// Outputs
	
	
  struct Input {
		let searchQuery: AnyObserver<String>
		let cancelQuery: AnyObserver<Void>
  }
	
  struct Output {
  }
  
  // MARK: - Init and deinit
	init(_ repoFetchService: RepoFetchServiceProtocol = RepoFetchService()) {
		input = Input(searchQuery: searchQuerySubject.asObserver(),
									cancelQuery: cancelSearchSubject.asObserver())
    output = Output()
  }
  deinit {
    print("\(self) dealloc")
  }
}
