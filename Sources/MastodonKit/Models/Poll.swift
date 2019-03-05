//
//  Poll.swift
//  MastodonKit
//
//  Created by Bruno Philipe on 03/04/19.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public class Poll: Codable {
    /// The id of the poll
    let id: String
    /// When voting on the poll closes.
    let expiresAt: Date?
    /// Whether voting has closed on the poll.
    let expired: Bool
    /// Whether multiple options can be picked for the poll, instead of a single one.
    let multiple: Bool
    /// Number of total votes the poll received so far.
    let votesCount: Int
    /// List of options in the poll.
    let options: [PollOption]
    /// Whether the active user has voted in the poll.
    let voted: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case expiresAt = "expires_at"
        case expired
        case multiple
        case votesCount = "votes_count"
        case options
        case voted
    }
}
