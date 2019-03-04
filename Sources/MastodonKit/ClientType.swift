//
//  ClientType.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 6/12/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public protocol ClientType {
    /// The user access token used to perform the network requests.
    var accessToken: String? { get set }
	/// The base URL for this client.
	var baseURL: String { get }

    /// Mastodon Client's initializer.
    ///
    /// - Parameters:
    ///   - baseURL: The Mastodon instance URL
    ///   - accessToken: The user access token used to perform the network requests (optional).
    ///   - session: The URLSession used to perform the network requests.
    init(baseURL: String, accessToken: String?, session: URLSession)

    /// Performs the network request.
    ///
    /// - Parameters:
    ///   - request: The request to be performed.
    ///   - resumeImmediatelly: Whether the `URLSessionDataTask` should be resumed before returning.
    ///   - completion: The completion block to be called when the request is complete.
    ///   - result: The request result.
    /// - Returns: `URLSessionDataTask` that will execute the request.
    @discardableResult
    func run<Model>(_ request: Request<Model>,
                    resumeImmediatelly: Bool,
                    completion: @escaping (_ result: Result<Model>) -> Void) -> URLSessionDataTask?
}

public extension ClientType {

	/// Performs the network request.
	///
	/// - Parameters:
	///   - request: The request to be performed.
	///   - completion: The completion block to be called when the request is complete.
	///   - result: The request result.
	func run<Model>(_ request: Request<Model>, completion: @escaping (_ result: Result<Model>) -> Void) {
		run(request, resumeImmediatelly: true, completion: completion)
	}
}
