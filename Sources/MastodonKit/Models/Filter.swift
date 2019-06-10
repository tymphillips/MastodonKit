//
//  Filter.swift
//  MastodonKit
//
//  Created by Bruno Philipe on 10.06.19.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public class Filter: Codable {

    public let id: String

    public let phrase: String

    public let context: Context

    public let expiresAt: Date?

    public let irreversible: Bool

    public let wholeWord: Bool

    public enum Context: String, Codable {
        case home
        case notification
        case `public`
        case thread
    }

    enum CodingKeys: String, CodingKey {
        case id
        case phrase
        case context
        case expiresAt = "expires_at"
        case irreversible
        case wholeWord = "whole_word"
    }
}
