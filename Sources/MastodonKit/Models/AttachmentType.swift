//
//  AttachmentType.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public enum AttachmentType: String, Codable {
    /// The attachment contains a static image.
    case image
    /// The attachment contains a video.
    case video
    /// The attachment contains a gif image.
    case gifv
    /// The attachment contains an unknown image file.
    case unknown

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        switch try container.decode(String.self) {
        case "image": self = .image
        case "video": self = .video
        case "gifv": self = .gifv
        default: self = .unknown
        }
    }
}
