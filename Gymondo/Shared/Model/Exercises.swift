//
//  Exersices.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation

typealias ExercisesResponse = BaseResponse<Exercises>

typealias Exercises = [Exercise]

// MARK: - Exercise
struct Exercise: Codable {
    let id: Int?
    let uuid: String?
    let created: Date?
    let creationDate: Date?
    let lastUpdate, lastUpdateGlobal: String?
    let category: Category?
    let muscles, musclesSecondary: [Muscle]?
    let equipment: [Category]?
    let license: License?
    let licenseAuthor: String?
    let images: [Image]?
    let exercises: [ExerciseElement]?
    let variations: Int?
    let videos: [Video]?
    let authorHistory: [String]?
    let totalAuthorsHistory: [String]?

    enum CodingKeys: String, CodingKey {
        case id, uuid, created
        case creationDate = "creation_date"
        case lastUpdate = "last_update"
        case lastUpdateGlobal = "last_update_global"
        case category, muscles
        case musclesSecondary = "muscles_secondary"
        case equipment, license
        case licenseAuthor = "license_author"
        case images, exercises, variations, videos
        case authorHistory = "author_history"
        case totalAuthorsHistory = "total_authors_history"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ExerciseElement
struct ExerciseElement: Codable {
    let id: Int?
    let uuid, name: String?
    let exerciseBase: Int?
    let description, created, creationDate: String?
    let language: Int?
    let notes: [Note]?
    let aliases: [Alias]?
    let license: Int?
    let licenseTitle, licenseObjectURL, licenseAuthor, licenseAuthorURL: String?
    let licenseDerivativeSourceURL: String?
    let authorHistory: [String]?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case exerciseBase = "exercise_base"
        case description, created
        case creationDate = "creation_date"
        case language, aliases, notes, license
        case licenseTitle = "license_title"
        case licenseObjectURL = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorURL = "license_author_url"
        case licenseDerivativeSourceURL = "license_derivative_source_url"
        case authorHistory = "author_history"
    }
}

// MARK: - Image
struct Image: Codable {
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

// MARK: - Note
struct Note: Codable {
    let id, exercise: Int?
    let comment: String?
}

// MARK: - Alias
struct Alias: Codable {
    let id: Int?
    let alias: String?
}

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
