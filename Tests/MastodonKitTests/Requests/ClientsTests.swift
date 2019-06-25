//
//  ClientsTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class ClientsTests: XCTestCase {
    func testRegisterApplication() {
        let request = Clients.register(clientName: "MastodonKitTestApplication", scopes: [])

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/apps")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = try! JSONSerialization.jsonObject(with: request.method.httpBody!, options: []) as! NSDictionary
        XCTAssertEqual(payload["client_name"] as? String, "MastodonKitTestApplication")
        XCTAssertEqual(payload["redirect_uris"] as? String, "urn:ietf:wg:oauth:2.0:oob")
        XCTAssertNil(payload["scopes"])
        XCTAssertNil(payload["website"])
    }

    func testRegisterApplicationWithRedirectURI() {
        let request = Clients.register(clientName: "MastodonKitTestApplication", redirectURI: "my-awesome-app://", scopes: [.read, .follow])

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/apps")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = try! JSONSerialization.jsonObject(with: request.method.httpBody!, options: []) as! NSDictionary
        XCTAssertEqual(payload["client_name"] as? String, "MastodonKitTestApplication")
        XCTAssertEqual(payload["redirect_uris"] as? String, "my-awesome-app://")
        XCTAssertEqual(payload["scopes"] as? [String], ["read", "follow"])
        XCTAssertNil(payload["website"])
    }

    func testRegisterApplicationWithStatusAndWebsite() {
        let request = Clients.register(clientName: "MastodonKitTestApplication", scopes: [.read, .write, .follow], website: "https://github.com/ornithocoder/MastodonKit")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/apps")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = try! JSONSerialization.jsonObject(with: request.method.httpBody!, options: []) as! NSDictionary
        XCTAssertEqual(payload["client_name"] as? String, "MastodonKitTestApplication")
        XCTAssertEqual(payload["redirect_uris"] as? String, "urn:ietf:wg:oauth:2.0:oob")
        XCTAssertEqual(payload["scopes"] as? [String], ["read", "write", "follow"])
        XCTAssertEqual(payload["website"] as? String, "https://github.com/ornithocoder/MastodonKit")
    }
}
