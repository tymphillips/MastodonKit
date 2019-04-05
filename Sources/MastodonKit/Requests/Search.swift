//
//  Search.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

/// `Search` requests.
public enum Search {
    /// Searches for content.
    ///
    /// - Parameters:
    ///   - query: The search query.
    ///   - resolve: Whether to resolve non-local accounts.
    /// - Returns: Request for `Results`.
    public static func search(query: String, resolve: Bool? = nil) -> Request<Results> {
        let parameters = [
            Parameter(name: "q", value: query),
            Parameter(name: "resolve", value: resolve.flatMap(trueOrNil))
        ]

        let method = HTTPMethod.get(.parameters(parameters))
        return Request<Results>(path: "/api/v1/search", method: method)
    }

	/// Asks the server to resolve a remote account.
	///
	/// This can be used to translate account references from one server to another.
	///
	/// - Parameters:
	///   - query: The search query. Should be the user's full username such as "gargron@mastodon.social"
	///   - following: Only return accounts the user is following.
	///   - limit: The maximum number of accounts to return. Defaults to `1`.
	/// - Returns: An array of matching accounts, with potentially only one element.
	public static func resolveRemoteAccount(query: String, following: Bool? = nil, limit: Int = 1) -> Request<[Account]> {
		let parameters = [
			Parameter(name: "q", value: query),
			Parameter(name: "resolve", value: trueOrNil(true)),
			Parameter(name: "following", value: following.flatMap(trueOrNil)),
			Parameter(name: "limit", value: "\(limit)")
		]

		let method = HTTPMethod.get(.parameters(parameters))
		return Request<[Account]>(path: "/api/v1/accounts/search", method: method)
	}
}
