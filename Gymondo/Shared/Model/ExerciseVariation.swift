//
//  ExerciseVariation.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

typealias ExercisesVariationResponse = BaseResponse<ExercisesVariation>

typealias ExercisesVariation = [ExerciseVariation]

// MARK: - ExerciseVariationElement
struct ExerciseVariation: Codable {
    let id: Int?
    let uuid, created, creationDate, lastUpdate: String?
    let lastUpdateGlobal: String?
    let category: Category?
    let muscles, musclesSecondary: [Muscle]?
    let equipment: [Category]?
    let license: License?
    let licenseAuthor: String?
    let images: [Image]?
    let exercises: [ExerciseElement]?
    let variations: Int?
    let videos: [Video]?
    let authorHistory, totalAuthorsHistory: [String]?

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
