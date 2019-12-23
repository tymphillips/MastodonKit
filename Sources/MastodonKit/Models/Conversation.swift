//
//  Conversation.swift
//  MastodonKit
//
//  Created by Tym Phillips on 12/22/19.
//

import Foundation

public class Conversation: Codable {
    /// The conversation ID.
    public let id: String
    /// The involved accounts.
    public let accounts: [Account]
    /// The last status in the thread.
    public let lastStatus: Status?
    /// Whether the message has been read.
    public let unread: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case accounts
        case lastStatus = "last_status"
        case unread
    }
}
