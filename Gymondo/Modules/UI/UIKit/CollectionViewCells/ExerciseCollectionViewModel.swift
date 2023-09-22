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
    func getImage(images: [ImageModel]?, completion: @escaping (UIImage) -> Void)
    func getName(exercises: [ExerciseElement]?, completion: @escaping (String) -> Void)
}

class ExerciseCollectionViewModelImpl: ExerciseCollectionViewModel {
    private let imageNetworkClient: ImageNetworkProvider
    private var cancellable: Set<AnyCancellable>
    
    private var commonExercises: CommonExercisesViewModel
        
    init(imageNetworkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        self.commonExercises = CommonExercisesViewModelImpl(imageNetworkClient: self.imageNetworkClient)
    }
    
    func getImage(images: [ImageModel]?, completion: @escaping (UIImage) -> Void) {
        images?.forEach({ img in
            if img.isMain ?? false {
                commonExercises
                    .getImage(path: img.image) { result in
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
        let data = commonExercises.getExerciseData(exercises: exercises)
        completion(data.name)
    }
}
