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
    var images: [ImageModel] { get }
    var exerciseVariations: ExercisesVariation { get }
    var isLoading: Bool { get }
    
    func getExerciseData(exercises: [ExerciseElement]?) -> (id: Int, name: String, description: String)
    func getImageUrl(image: ImageModel) -> URL
    func getMainImageUrl(images: [ImageModel]?) -> URL?
    func pushVariation(exerciseId: Int?)
}

class ExerciseDetailsViewModelImpl: ExerciseDetailsViewModel {
    @Published private(set) var name: String = ""
    @Published private(set) var description: String = ""
    @Published private(set) var images: [ImageModel] = []
    @Published private(set) var exerciseVariations: ExercisesVariation = []
    @Published private(set) var isLoading: Bool = true
    
    private var exerciseId: Int
    private let wgerNetworkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkProvider
    private var commonExercises: CommonExercisesViewModel
    private var coordinator: MainCoordinator
    
    private var cancellable: Set<AnyCancellable>
    
    init(exerciseId: Int,
         wgerNetworkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkProvider,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
         coordinator: MainCoordinator) {
        self.exerciseId = exerciseId
        self.wgerNetworkClient = wgerNetworkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        self.commonExercises = CommonExercisesViewModelImpl(imageNetworkClient: self.imageNetworkClient)
        self.coordinator = coordinator
        getDetails()
    }
    
    func getExerciseData(exercises: [ExerciseElement]?) -> (id: Int, name: String, description: String) {
        let data = commonExercises.getExerciseData(exercises: exercises)
        return data
    }
    
    func getMainImageUrl(images: [ImageModel]?) -> URL? {
        if let images = images {
            for image in images {
                if image.isMain ?? false {
                    return self.getImageUrl(image: image)
                }
            }
        }
        
        return nil
    }
    
    func getImageUrl(image: ImageModel) -> URL {
        if let path = image.image,
           let url = URL(string: path){
            return url
        }
        
        return URL(string: "")!
    }
    
    func pushVariation(exerciseId: Int?) {
        if let exerciseId = exerciseId {
            coordinator.exerciseDetails(exerciseId: exerciseId)
        }
    }
    
    private func getDetails() {
        wgerNetworkClient
            .getDetails(exerciseId: exerciseId)
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    break
                }
            } receiveValue: { [weak self] details in
                guard let self = self else { return }
                let data = self.getExerciseData(exercises: details.exercises)
                self.name = data.name
                self.description = data.description.removeHtmlTags
                
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
                if var results = variations.results {
                    results.removeAll { $0.id ?? 0 == self.exerciseId }
                    self.exerciseVariations = results
                }
            }
            .store(in: &cancellable)
    }
}
