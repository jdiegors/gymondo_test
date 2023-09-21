//
//  Video.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    let id: Int?
    let uuid: String?
    let exerciseBase: Int?
    let exerciseBaseUUID: String?
    let video: String?
    let isMain: Bool?
    let size: Int?
    let duration: String?
    let width, height: Int?
    let codec: String?
    let codecLong: String?
    let license: Int?
    let licenseTitle, licenseObjectURL: String?
    let licenseAuthor: String?
    let licenseAuthorURL, licenseDerivativeSourceURL: String?
    let authorHistory: [String]?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case exerciseBase = "exercise_base"
        case exerciseBaseUUID = "exercise_base_uuid"
        case video
        case isMain = "is_main"
        case size, duration, width, height, codec
        case codecLong = "codec_long"
        case license
        case licenseTitle = "license_title"
        case licenseObjectURL = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorURL = "license_author_url"
        case licenseDerivativeSourceURL = "license_derivative_source_url"
        case authorHistory = "author_history"
    }
}
