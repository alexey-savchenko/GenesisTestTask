//
//  RepoFetchService.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

/// Service that queries GitHub repositories based on specified query
protocol RepoFetchServiceProtocol {
	/// Search repositories
	///
	/// - Parameter query: Specified query
	/// - Returns: Observable of arrays of RepoInfo's
	func searchRepos(using query: String) -> Observable<[RepoInfo]>
	/// Cancel pending query
	func cancelQuery()
	/// Indicates if there are some pending queries
	var isQuerying: Observable<Bool> { get }
}

class RepoFetchService: NSObject, RepoFetchServiceProtocol {
	
	// MARK: - Init and deinit
	
	init(_ historySaveService: SearchHistoryInfoStoreProtocol = CoreDataStack.shared) {
		self.historySaveService = historySaveService
		super.init()
		
		operationQueue.maxConcurrentOperationCount = 2
	}
	
	deinit {
		print("\(self) dealloc")
	}
	
	// MARK: - Private Properties
	
	private let historySaveService: SearchHistoryInfoStoreProtocol
	private let isQueryingSubject = PublishSubject<Bool>()
	private let disposeBag = DisposeBag()
	private let operationQueue = OperationQueue()
	private var pendingRequests = [DataRequest]()
	
	// MARK: - Public Properties
	
	var isQuerying: Observable<Bool> {
		return isQueryingSubject.asObservable()
	}

	// MARK: - Functions
	
	func cancelQuery() {
		operationQueue.cancelAllOperations()
		pendingRequests.forEach { $0.cancel() }
		self.isQueryingSubject.onNext(false)
	}
	
	func searchRepos(using query: String) -> Observable<[RepoInfo]> {
		return Observable.create { [unowned self] observer in

			let reposPart1 = PublishSubject<[RepoInfo]>()
			let reposPart2 = PublishSubject<[RepoInfo]>()
			
			self.isQueryingSubject.onNext(true)
			
			let loadPart1Operation = BlockOperation {
				let request = Alamofire
					.request(SearchReposAPIAction(query: query, page: 1))
					.responseJSON(completionHandler: { (dataResponse) in
						switch dataResponse.result {
						case .success:
							if let data = dataResponse.data,
								let searchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) {
								
								reposPart1.onNext(searchResponse.items)
							} else {
								self.isQueryingSubject.onNext(false)
								observer.onError("Corrupted response")
							}
						case .failure(let error):
							self.isQueryingSubject.onNext(false)
							if !(error.localizedDescription == "cancelled") {
								observer.onError(error)
							}
						}
					})
				self.pendingRequests.append(request)
			}
			
			let loadPart2Operation = BlockOperation {
				let request = Alamofire
					.request(SearchReposAPIAction(query: query, page: 2))
					.responseJSON(completionHandler: { (dataResponse) in
						switch dataResponse.result {
						case .success:
							if let data = dataResponse.data,
								let searchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) {
								
								reposPart2.onNext(searchResponse.items)
							} else {
								self.isQueryingSubject.onNext(false)
								observer.onError("Corrupted response")
							}
						case .failure(let error):
							self.isQueryingSubject.onNext(false)
							if !(error.localizedDescription == "cancelled") {
								observer.onError(error)
							}
						}
					})
				self.pendingRequests.append(request)
			}
			
			self.operationQueue.addOperations([loadPart1Operation, loadPart2Operation], waitUntilFinished: false)
			
			Observable
				.zip(reposPart1, reposPart2)
				.map { (part1, part2) in return part1 + part2 }
				.do(onNext: { [unowned self] (repos) in
					self.isQueryingSubject.onNext(false)
					self.historySaveService.saveSearch(query, reposInfo: repos)
				})
				.subscribe(observer)
				.disposed(by: self.disposeBag)

			return Disposables.create()
		}
	}
}

class MockFetchService: RepoFetchServiceProtocol {
	
	private let isQueryingSubject = PublishSubject<Bool>()
	
	var isQuerying: Observable<Bool> {
		return isQueryingSubject.asObservable()
	}
	
	func cancelQuery() {
	}
	
	func searchRepos(using query: String) -> Observable<[RepoInfo]> {
		isQueryingSubject.onNext(true)
		let stubbedResponseData = JSONStubs.searchResponse.data(using: String.Encoding.utf8)
		let stubbedResponse = try! JSONDecoder().decode(SearchResponse.self, from: stubbedResponseData!)
		isQueryingSubject.onNext(false)
		return Observable.just(stubbedResponse.items)
	}
}
