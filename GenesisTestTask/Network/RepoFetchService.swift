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

protocol RepoFetchServiceProtocol {
	func searchRepos(using query: String) -> Observable<[RepoInfo]>
	func cancelQuery()
	var isQuerying: Observable<Bool> { get }
}

class RepoFetchService: RepoFetchServiceProtocol {
	
	init(_ historySaveService: SearchHistoryInfoStoreProtocol = CoreDataStack.shared) {
		self.historySaveService = historySaveService
	}
	
	deinit {
		print("\(self) dealloc")
	}
	
	private let historySaveService: SearchHistoryInfoStoreProtocol
	private let isQueryingSubject = PublishSubject<Bool>()
	
	var isQuerying: Observable<Bool> {
		return isQueryingSubject.asObservable()
	}
	
	var currentRequest: DataRequest?
	
	func cancelQuery() {
		currentRequest?.cancel()
	}
	
	func searchRepos(using query: String) -> Observable<[RepoInfo]> {
		return Observable.create { [unowned self] observer in

			self.isQueryingSubject.onNext(true)
			self.currentRequest = Alamofire
				.request(SearchReposAPIAction(query: query, page: 1))
				.responseJSON(completionHandler: { (dataResponse) in
					switch dataResponse.result {
					case .success:
						if let data = dataResponse.data,
							let searchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) {
							self.historySaveService.saveSearch(query, reposInfo: searchResponse.items)
							self.isQueryingSubject.onNext(false)
							observer.onNext(searchResponse.items)
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
			
			return Disposables.create { [unowned self] in self.currentRequest?.cancel() }
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
