//
//  Payload.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/28/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

enum Payload {
    case parameters([Parameter]?)
    case form([FormParameter]?)
    case media(MediaAttachment?)
    case empty
}

extension Payload {
    static let formBoundary = "xAb54_MastodonKit_xAb54"

    var items: [URLQueryItem]? {
        switch self {
        case .parameters(let parameters): return parameters?.compactMap(toQueryItem)
        case .form, .media, .empty: return nil
        }
    }

    var data: Data? {
        switch self {
        case .parameters(let parameters):
            return parameters?.compactMap(toString).joined(separator: "&").data(using: .utf8)

        case .form(let parameters):
            return parameters?.compactMap({ $0.formItemValue })
                              .reduce(Data(), +)
                              .appending("--\(Payload.formBoundary)--")

        case .media(let mediaAttachment):
            return mediaAttachment.flatMap(Data.init)

        case .empty:
            return nil
        }
    }

    var type: String? {
        switch self {
        case .parameters(.some):
            return "application/x-www-form-urlencoded; charset=utf-8"

        case .media(.some), .form(.some):
            return "multipart/form-data; boundary=\(Payload.formBoundary)"

        case .parameters(.none), .media(.none), .form(.none), .empty:
            return nil
        }
    }
}

protocol FormParameter {
    var formItemValue: Data? { get }
}
