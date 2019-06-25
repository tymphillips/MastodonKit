//
//  Clients.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

/// `Clients` requests.
public enum Clients {
    /// Registers an application.
    ///
    /// - Parameters:
    ///   - appName: Name of your application.
    ///   - redirectURI: Where the user should be redirected after authorization (for no redirect, omit this parameter).
    ///   - scopes: Application's access scopes.
    ///   - website: URL to the homepage of your app.
    /// - Returns: Request for `ClientApplication`.
    public static func register(clientName: String,
                                redirectURI: String = "urn:ietf:wg:oauth:2.0:oob",
                                scopes: [AccessScope],
                                website: String? = nil) -> Request<ClientApplication> {
        let parameters: [String: AnyEncodable?] = [
            "client_name": AnyEncodable(clientName),
            "redirect_uris": AnyEncodable(redirectURI),
            "website": website.map { AnyEncodable($0) },
            "scopes": scopes.isEmpty ? nil : AnyEncodable(scopes)
        ]

        let method = HTTPMethod.post(.json(encoding: parameters.compactMapValues { $0 }))
        return Request<ClientApplication>(path: "/api/v1/apps", method: method)
    }
}
