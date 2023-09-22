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
    let images: [ImageModel]?
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
