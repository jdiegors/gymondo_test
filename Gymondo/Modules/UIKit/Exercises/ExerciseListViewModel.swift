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
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?)
    func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel
}

class ExerciseListViewModelImpl: ExerciseListViewModel {
    private let networkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkClient
    private var cancellable: Set<AnyCancellable>
    private weak var viewModelConsumer: ExerciseListViewModelConsumer?
    
    private(set) var exercisesList: Exercises = []
    
    init(networkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkClient,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.networkClient = networkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
        getExercises()
    }
    
    func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?) {
        self.viewModelConsumer = viewModelConsumer
    }
    
    func getExercises() {
        networkClient
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
        let vm: ExerciseCollectionViewModel = ExerciseCollectionViewModelImpl(networkClient: imageNetworkClient)
        return vm
    }
}
