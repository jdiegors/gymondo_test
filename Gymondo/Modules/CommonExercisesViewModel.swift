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
    func getExerciseData(exercises: [ExerciseElement]?) -> (id: Int, name: String, description: String)
    func getImage(path: String?, completion: @escaping (Result<UIImage, Error>) -> Void)
    func showError(error: Error, completion: @escaping () -> Void)
}

class CommonExercisesViewModelImpl: CommonExercisesViewModel {
    private let imageNetworkClient: ImageNetworkProvider
    private var cancellable: Set<AnyCancellable>
            
    init(imageNetworkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
    }
    
    func getExerciseData(exercises: [ExerciseElement]?) -> (id: Int, name: String, description: String) {
        if let exercises = exercises {
            for exercise in exercises {
                if exercises.count == 1 {
                    return (exercise.id ?? 0, exercise.name ?? "Not found", exercise.description ?? "")
                } else if exercise.language == 2 {
                    return (exercise.id ?? 0, exercise.name ?? "Not found", exercise.description ?? "")
                }
            }
        }
        
        return (0, "","")
    }
    
    func getImage(path: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        imageNetworkClient
            .getImage(path: path)
            .sink { _ in } receiveValue: { image in
                completion(.success(image))
            }
            .store(in: &cancellable)
    }
    
    func showError(error: Error, completion: @escaping () -> Void) {
        if let error = error as? ApiError {
            Messages.shared.showAlert(title: "Error", message: "An error of type '\(error.description)' occurs", completion: {
                completion()
            })
        } else {
            Messages.shared.showAlert(title: "Error", message: "An unknown error occur", completion: {})
        }
    }
}
