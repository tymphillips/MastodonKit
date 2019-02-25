//
//  ProfileMetadata.swift
//  MastodonKit
//
//  Created by Bruno Philipe on 22.02.19.
//

import Foundation

public struct MetadataField: Encodable {
	public var name: String
	public var value: String

	public init(name: String, value: String) {
		self.name = name
		self.value = value
	}
}

extension MetadataField: StringDictionaryConvertible {
	var dictionaryValue: [String : String] {
		return ["name": name, "value": value]
	}
}

public struct VerifiableMetadataField: Codable {
	public var name: String
	public var value: String
	public var verification: Date?

	enum CodingKeys: String, CodingKey {
		case name, value
		case verification = "verified_at"
	}
}

