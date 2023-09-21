//
//  Note.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

// MARK: - Note
struct Note: Codable {
    let id, exercise: Int?
    let comment: String?
}
