//
//  MockNetworkClient.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine
@testable import Gymondo

class MockNetworkClient: NetworkProvider {
    var response: (Data?, Error?)
    
    init(response: (Data?, Error?)) {
        self.response = response
    }
    
    func request(from endPoint: Gymondo.APIBuilder) -> AnyPublisher<Data, Error> {
        if let error = response.1 {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        if let data = response.0 {
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: ApiError.unknown)
            .eraseToAnyPublisher()
    }
}
