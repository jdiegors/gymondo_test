//
//  License.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

// MARK: - License
struct License: Codable {
    let id: Int?
    let fullName, shortName: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case shortName = "short_name"
        case url
    }
}
