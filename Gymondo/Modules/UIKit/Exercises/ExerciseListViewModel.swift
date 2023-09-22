//
//  ExerciseListViewModel.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

protocol ExerciseListViewModelConsumer: AnyObject {
    func updateCollectionView()
}

protocol ExerciseListViewModel: AnyObject {
    var exercisesList: Exercises { get }
    var coordinator: MainCoordinator { get }
    var isLoading: Bool { get }
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?)
    func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel
}

class ExerciseListViewModelImpl: ExerciseListViewModel {
    private let wgerNetworkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkClient
    private var cancellable: Set<AnyCancellable>
    private weak var viewModelConsumer: ExerciseListViewModelConsumer?
    private var commonExercises: CommonExercisesViewModel
    
    private(set) var coordinator: MainCoordinator
    private(set) var exercisesList: Exercises = []
    private(set) var isLoading: Bool = true
    
    init(wgerNetworkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkClient,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
         coordinator: MainCoordinator) {
        self.wgerNetworkClient = wgerNetworkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        self.coordinator = coordinator
        self.commonExercises = CommonExercisesViewModelImpl(imageNetworkClient: self.imageNetworkClient)
        getExercises()
    }
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?) {
        self.viewModelConsumer = viewModelConsumer
    }
    
    func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel {
        let vm: ExerciseCollectionViewModel = ExerciseCollectionViewModelImpl(imageNetworkClient: imageNetworkClient)
        return vm
    }
    
    private func getExercises() {
        wgerNetworkClient
            .getExercises()
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    commonExercises.showError(error: error) {
                        self.getExercises()
                    }
                }
            } receiveValue: { [weak self] exercises in
                guard let self = self else { return }
                self.exercisesList =  exercises.results ?? []
                viewModelConsumer?.updateCollectionView()
            }
            .store(in: &cancellable)
    }
}
