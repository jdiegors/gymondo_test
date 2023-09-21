//
//  CommonExercisesViewModel.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation
import Combine
import UIKit

protocol CommonExercisesViewModel: AnyObject {
    func getNameAndDescription(exercises: [ExerciseElement]?, completion: @escaping (String, String) -> Void)
    func getImage(path: String?, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class CommonExercisesViewModelImpl: CommonExercisesViewModel {
    private let imageNetworkClient: ImageNetworkProvider
    private var cancellable: Set<AnyCancellable>
            
    init(imageNetworkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
    }
    
    func getNameAndDescription(exercises: [ExerciseElement]?, completion: @escaping (String, String) -> Void) {
        exercises?.forEach({ exercise in
            if exercises?.count == 1 {
                completion(exercise.name ?? "Not found", exercise.description ?? "")
            } else if exercise.language == 2 {
                completion(exercise.name ?? "Not found", exercise.description ?? "")
            }
        })
    }
    
    func getImage(path: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        imageNetworkClient
            .getImage(path: path)
            .sink { _ in } receiveValue: { image in
                completion(.success(image))
            }
            .store(in: &cancellable)
    }
}
