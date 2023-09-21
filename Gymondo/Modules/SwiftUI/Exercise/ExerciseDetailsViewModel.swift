//
//  ExerciseDetailsViewModel.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation
import UIKit
import Combine

protocol ExerciseDetailsViewModel: ObservableObject, AnyObject {
    var name: String { get }
    var description: String { get }
    var images: [Image] { get }
    var exerciseVariations: ExercisesVariation { get }
    
    func getNameAndDescription(exercises: [ExerciseElement]?, completion: @escaping (String, String) -> Void)
    func getImageUrl(image: Image) -> URL
}

class ExerciseDetailsViewModelImpl: ExerciseDetailsViewModel {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var images: [Image] = []
    @Published var exerciseVariations: ExercisesVariation = []
    
    private let exerciseId: Int
    private let wgerNetworkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkProvider
    private var commonExercises: CommonExercisesViewModel
    
    private var cancellable: Set<AnyCancellable>
    
    init(exerciseId: Int,
         wgerNetworkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.exerciseId = exerciseId
        self.wgerNetworkClient = wgerNetworkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        self.commonExercises = CommonExercisesViewModelImpl(imageNetworkClient: self.imageNetworkClient)
        getDetails()
    }
    
    func getNameAndDescription(exercises: [ExerciseElement]?, completion: @escaping (String, String) -> Void) {
        commonExercises.getNameAndDescription(exercises: exercises, completion: completion)
    }
    
    func getImageUrl(image: Image) -> URL {
        if let path = image.image,
           let url = URL(string: path){
            return url
        }
        
        return URL(string: "")!
    }
    
    private func getDetails() {
        wgerNetworkClient
            .getDetails(exerciseId: exerciseId)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            } receiveValue: { [weak self] details in
                guard let self = self else { return }
                self.getNameAndDescription(exercises: details.exercises) { strName, strDescription in
                    self.name = strName
                    self.description = strDescription
                }
                
                if let images = details.images,
                   images.count > 0 {
                    self.images = images
                }
                
                if let variation = details.variations {
                    self.getVariations(variation: variation)
                }
            }
            .store(in: &cancellable)
    }
    
    private func getVariations(variation: Int) {
        wgerNetworkClient
            .getVariations(variation: variation)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            } receiveValue: { [weak self] variations in
                guard let self = self else { return }
                if let results = variations.results {
                    self.exerciseVariations = results
                }
            }
            .store(in: &cancellable)
    }
}
