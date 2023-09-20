//
//  ExerciseCollectionViewModel.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import UIKit
import Combine

protocol ExerciseCollectionViewModel: AnyObject {
    func getImage(images: [Image]?, completion: @escaping (UIImage) -> Void)
    func getName(exercises: [ExerciseElement]?, completion: @escaping (String) -> Void)
}

class ExerciseCollectionViewModelImpl: ExerciseCollectionViewModel {
    private let networkClient: ImageNetworkProvider
    private var cancellable: Set<AnyCancellable>
        
    init(networkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.networkClient = networkClient
        self.cancellable = cancellable
    }
    
    func getImage(images: [Image]?, completion: @escaping (UIImage) -> Void) {
        images?.forEach({ img in
            if img.isMain ?? false {
                getImage(path: img.image) { result in
                    switch result {
                    case .success(let image):
                        completion(image)
                    case .failure(_):
                        break
                    }
                }
            }
        })
    }
    
    func getName(exercises: [ExerciseElement]?, completion: @escaping (String) -> Void) {
        exercises?.forEach({ exercise in
            if exercises?.count == 1 {
                completion(exercise.name ?? "Not found")
            } else if exercise.language == 2 {
                completion(exercise.name ?? "Not found")
            }
        })
    }
    
    private func getImage(path: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        networkClient
            .getImage(path: path)
            .sink { _ in } receiveValue: { image in
                completion(.success(image))
            }
            .store(in: &cancellable)
    }
}
