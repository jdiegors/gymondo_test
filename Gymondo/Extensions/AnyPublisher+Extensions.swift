//
//  AnyPublisher+Extensions.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

extension AnyPublisher where Output == Data, Failure == Error {
    func decode<T: Decodable>(jsonDecoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Failure> {
        tryMap { data -> T in
            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.standardTUTC,
                DateFormatter.standardUTC
            ]
            
            return try jsonDecoder.decode(T.self, from: data)
        }.eraseToAnyPublisher()
    }
}
