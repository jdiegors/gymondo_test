//
//  Image.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

// MARK: - Image
struct ImageModel: Codable {
    let id: Int?
    let uuid: String?
    let exerciseBase: Int?
    let exerciseBaseUUID: String?
    let image: String?
    let isMain: Bool?
    let style: String?
    let license: Int?
    let licenseTitle, licenseObjectURL, licenseAuthor, licenseAuthorURL: String?
    let licenseDerivativeSourceURL: String?
    let authorHistory: [String]?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case exerciseBase = "exercise_base"
        case exerciseBaseUUID = "exercise_base_uuid"
        case image
        case isMain = "is_main"
        case style, license
        case licenseTitle = "license_title"
        case licenseObjectURL = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorURL = "license_author_url"
        case licenseDerivativeSourceURL = "license_derivative_source_url"
        case authorHistory = "author_history"
    }
}
