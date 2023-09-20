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
            .flatMap { (data, response) -> AnyPublisher<Data, Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: ApiError.unknown)
                        .eraseToAnyPublisher()
                }
                
                var errorType: ApiError
                
                switch httpResponse.statusCode {
                case 200:
                    return Just(data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                case 404:
                    errorType = .notFound
                case 401:
                    errorType = .unauthorized
                case 403:
                    errorType = .forbidden
                case 500:
                    errorType = .internalServerError
                case 502:
                    errorType = .badRequest
                case 503:
                    errorType = .serviceUnavailable
                case 504:
                    errorType = .gatewayTimeOut
                default:
                    errorType = .unknown
                }
                
                return Fail(error: errorType)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
