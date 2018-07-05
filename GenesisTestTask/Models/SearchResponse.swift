//
//  SearchResponse.swift
//  GenesisTestTask
//
//  Created by Alexey Savchenko on 7/5/18.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
	let totalCount: Int
	let incompleteResults: Bool
	let items: [RepoInfo]
	
	enum CodingKeys: String, CodingKey {
		case totalCount = "total_count"
		case incompleteResults = "incomplete_results"
		case items
	}
}

enum DefaultBranch: String, Codable {
	case ghPages = "gh-pages"
	case master = "master"
	case tutorial = "tutorial"
}

struct License: Codable {
	let key, name: String
	let spdxID, url: String?
	let nodeID: String
	
	enum CodingKeys: String, CodingKey {
		case key, name
		case spdxID = "spdx_id"
		case url
		case nodeID = "node_id"
	}
}

struct Owner: Codable {
	let login: String
	let id: Int
	let nodeID, avatarURL, gravatarID, url: String
	let htmlURL, followersURL, followingURL, gistsURL: String
	let starredURL, subscriptionsURL, organizationsURL, reposURL: String
	let eventsURL, receivedEventsURL: String
	let type: Type
	let siteAdmin: Bool
	
	enum CodingKeys: String, CodingKey {
		case login, id
		case nodeID = "node_id"
		case avatarURL = "avatar_url"
		case gravatarID = "gravatar_id"
		case url
		case htmlURL = "html_url"
		case followersURL = "followers_url"
		case followingURL = "following_url"
		case gistsURL = "gists_url"
		case starredURL = "starred_url"
		case subscriptionsURL = "subscriptions_url"
		case organizationsURL = "organizations_url"
		case reposURL = "repos_url"
		case eventsURL = "events_url"
		case receivedEventsURL = "received_events_url"
		case type
		case siteAdmin = "site_admin"
	}
	
	enum `Type`: String, Codable {
		case organization = "Organization"
		case user = "User"
	}
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
