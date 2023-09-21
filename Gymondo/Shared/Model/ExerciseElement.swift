//
//  ExerciseElement.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

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
