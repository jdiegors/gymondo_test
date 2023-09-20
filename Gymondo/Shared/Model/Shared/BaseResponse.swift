//
//  BaseResponse.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

struct BaseResponse<T: Decodable>: Decodable {
    let count: Int?
    let next, previous: String?
    let results: T?
}
