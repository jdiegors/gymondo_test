//
//  WgerNetworkProvider.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

protocol WgerNetworkProvider: AnyObject {
    func getExercises() -> AnyPublisher<ExercisesResponse, Error>
}

class WgerNetworkClient: WgerNetworkProvider {
    var networkClient: NetworkProvider
    
    init(networkClient: NetworkProvider) {
        self.networkClient = networkClient
    }
    
    func getExercises() -> AnyPublisher<ExercisesResponse, Error> {
        networkClient.request(from: WgerRouter.exercise).decode()
    }
}
