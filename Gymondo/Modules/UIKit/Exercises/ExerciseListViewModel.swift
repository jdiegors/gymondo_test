//
//  ExerciseListViewModel.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

protocol ExerciseListViewModelConsumer: AnyObject {
    func updateTableView()
}

protocol ExerciseListViewModel: AnyObject {
    var exercisesList: Exercises { get }
    var coordinator: MainCoordinator { get }
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?)
    func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel
}

class ExerciseListViewModelImpl: ExerciseListViewModel {
    private let wgerNetworkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkClient
    private var cancellable: Set<AnyCancellable>
    private weak var viewModelConsumer: ExerciseListViewModelConsumer?
    
    private(set) var coordinator: MainCoordinator
    private(set) var exercisesList: Exercises = []
    
    init(wgerNetworkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkClient,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
         coordinator: MainCoordinator) {
        self.wgerNetworkClient = wgerNetworkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        self.coordinator = coordinator
        getExercises()
    }
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?) {
        self.viewModelConsumer = viewModelConsumer
    }
    
    func getExercises() {
        wgerNetworkClient
            .getExercises()
            .sink { result in
                switch result {
                case .finished:
                    print("OK")
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            } receiveValue: { [weak self] exercises in
                guard let self = self else { return }
                self.exercisesList =  exercises.results ?? []
                viewModelConsumer?.updateTableView()
            }
            .store(in: &cancellable)
    }
    
    func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel {
        let vm: ExerciseCollectionViewModel = ExerciseCollectionViewModelImpl(imageNetworkClient: imageNetworkClient)
        return vm
    }
}
