//
//  NetworkClient.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

class NetworkClient: NetworkProvider {
    func request(from endPoint: APIBuilder) -> AnyPublisher<Data, Error> {
        guard let urlRequest = endPoint.urlRequest else {
            return Fail(error: ApiError.unknown)
                .eraseToAnyPublisher()
        }
        
        let session = URLSession.shared
        return session
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in ApiError.unknown }
            .flatMap { (data, response) -> AnyPublisher<Data, Never> in
                return Just(data)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
