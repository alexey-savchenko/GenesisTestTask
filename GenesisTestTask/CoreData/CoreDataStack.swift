//
//  CoreDataStack.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/6/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import CoreData
import RxSwift

protocol SearchHistoryInfoProviderProtocol {
	var historyItems: Observable<[SearchHistoryItem]> { get }
}

protocol SearchHistoryInfoStoreProtocol {
	func saveSearch(_ searchQuery: String, reposInfo: [RepoInfo])
}

class CoreDataStack {
	let modelName = "CoreDataModel"
	static let shared = CoreDataStack()
	private let persistentContainer: NSPersistentContainer
	
	lazy var managedObjectContext: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()
	
	private init() {
		persistentContainer = NSPersistentContainer(name: modelName)
		persistentContainer.loadPersistentStores { (_, error) in
			guard error == nil else {
				fatalError(error!.localizedDescription)
			}
		}
	}
	
	private func fetchSearchHistory() -> Observable<[SearchHistoryItem]> {
		let request: NSFetchRequest<SearchHistoryItem> = SearchHistoryItem.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "searchDate", ascending: false)]
		let results = try? managedObjectContext.fetch(request)
		return Observable.just(results ?? [])
	}
}

extension CoreDataStack: SearchHistoryInfoProviderProtocol {
	var historyItems: Observable<[SearchHistoryItem]> {
		return fetchSearchHistory()
	}
}

extension CoreDataStack: SearchHistoryInfoStoreProtocol {
	func saveSearch(_ searchQuery: String, reposInfo: [RepoInfo]) {
		let historyItem = SearchHistoryItem(context: managedObjectContext)
		historyItem.searchDate = Date()
		historyItem.searchQuery = searchQuery
		historyItem.searchResults = try? JSONEncoder().encode(reposInfo)
		try? managedObjectContext.save()
	}
}
