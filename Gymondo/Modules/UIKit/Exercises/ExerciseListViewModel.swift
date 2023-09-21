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
    func initializeExerciseDetails(exerciseId: Int) -> ExerciseDetailsViewModelImpl?
}

class ExerciseListViewModelImpl: ExerciseListViewModel {
    private let wgerNetworkClient: WgerNetworkProvider
    private let imageNetworkClient: ImageNetworkClient
    private var cancellable: Set<AnyCancellable>
    private weak var viewModelConsumer: ExerciseListViewModelConsumer?
    
    private(set) var exercisesList: Exercises = []
    
    init(wgerNetworkClient: WgerNetworkProvider,
         imageNetworkClient: ImageNetworkClient,
         cancellable: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.wgerNetworkClient = wgerNetworkClient
        self.imageNetworkClient = imageNetworkClient
        self.cancellable = cancellable
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

extension ExerciseListViewModelImpl: ExerciseDetailsViewFactory {
    func initializeExerciseDetails(exerciseId: Int) -> ExerciseDetailsViewModelImpl? {
        let imageNetworkClient = ImageNetworkClient(networkClient: NetworkClient())
        let wgerNetworkClient = WgerNetworkClient(networkClient: NetworkClient())
        let vm: any ExerciseDetailsViewModel = ExerciseDetailsViewModelImpl(
            exerciseId: exerciseId,
            wgerNetworkClient: wgerNetworkClient,
            imageNetworkClient: imageNetworkClient
        )
        
        guard let viewmodel = vm as? ExerciseDetailsViewModelImpl else {
            return nil
        }
        return viewmodel
    }
}
