//
//  SearchReposAPIAction.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import Alamofire

struct SearchReposAPIAction: APIAction {
	
	let query: String
	let page: Int
	let perPage = 15
	let order = Order.descending
	let sortMode = SortMode.stars
	
	var method: HTTPMethod {
		return .get
	}
	
	var path: String {
		return "/search/repositories"
	}
	
	var actionParameters: [String: Any] {
		return ["q": query,
						"sort": sortMode.rawValue,
						"order": order.rawValue,
						"page": page,
						"per_page": perPage]
	}
	
	var baseURL: String {
		return "https://api.github.com"
	}
	
	var authHeader: [String : String] {
		return [:]
	}
	
	var encoding: ParameterEncoding {
		return URLEncoding.default
	}
	
	enum Order: String {
		case ascending = "asc"
		case descending = "desc"
	}
	
	enum SortMode: String {
		case stars = "stars"
		case forks = "forks"
		case updated = "updated"
	}
}

let s = SearchReposAPIAction(query: "",
														 page: 2)
