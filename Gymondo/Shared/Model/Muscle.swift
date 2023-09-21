//
//  Muscle.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

// MARK: - Muscle
struct Muscle: Codable {
    let id: Int?
    let name, nameEn: String?
    let isFront: Bool?
    let imageURLMain, imageURLSecondary: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameEn = "name_en"
        case isFront = "is_front"
        case imageURLMain = "image_url_main"
        case imageURLSecondary = "image_url_secondary"
    }
}
