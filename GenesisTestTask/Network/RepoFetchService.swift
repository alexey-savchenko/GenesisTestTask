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
}

class RepoFetchService: RepoFetchServiceProtocol {
	
	var currentRequest: DataRequest?
	
	func cancelQuery() {
		currentRequest?.cancel()
	}
	
	func searchRepos(using query: String) -> Observable<[RepoInfo]> {
		return Observable.create { [unowned self] observer in
			
			
			
			return Disposables.create { [unowned self] in self.currentRequest?.cancel() }
		}
	}
	
	deinit {
		print("\(self) dealloc")
	}
}

class MockFetchService: RepoFetchServiceProtocol {
	
	func cancelQuery() {
		
	}
	
	func searchRepos(using query: String) -> Observable<[RepoInfo]> {
		let stubbedResponseData = JSONStubs.searchResponse.data(using: String.Encoding.utf8)
		let stubbedResponse = try! JSONDecoder().decode(SearchResponse.self, from: stubbedResponseData!)
		return Observable.just(stubbedResponse.items)
	}
}
