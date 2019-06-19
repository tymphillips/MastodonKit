//
//  Polls.swift
//  MastodonKit
//
//  Created by Bruno Philipe on 17/06/19.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public enum Polls {

    public static func poll(id: String) -> Request<Poll> {
        return Request(path: "/api/v1/polls/\(id)")
    }

    public static func vote(pollID: String, optionIndices: IndexSet) -> Request<Poll> {
        let parameters = optionIndices.map(toArrayOfParameters(withName: "choices"))
        let method = HTTPMethod.post(.parameters(parameters))
        return Request<Poll>(path: "/api/v1/polls/\(pollID)/votes", method: method)
    }
}
