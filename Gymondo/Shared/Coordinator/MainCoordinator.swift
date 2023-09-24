//
//  MainCoordinator.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 21/9/23.
//

import UIKit
import SwiftUI

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkClient = NetworkClient()
        let wgerNetworkClient = WgerNetworkClient(networkClient: networkClient)
        let imageNetworkClient = ImageNetworkClient(networkClient: networkClient)
        let viewModel = ExerciseListViewModelImpl(wgerNetworkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient, coordinator: self)
        let viewController = ExerciseListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func exerciseDetails(exerciseId: Int) {
        let imageNetworkClient = ImageNetworkClient(networkClient: NetworkClient())
        let wgerNetworkClient = WgerNetworkClient(networkClient: NetworkClient())
        let vm: any ExerciseDetailsViewModel = ExerciseDetailsViewModelImpl(
            exerciseId: exerciseId,
            wgerNetworkClient: wgerNetworkClient,
            imageNetworkClient: imageNetworkClient,
            coordinator: self
        )
        
        if let viewmodel = vm as? ExerciseDetailsViewModelImpl {
            let swiftUIView = ExerciseDetailsView(viewModel: viewmodel)
                .accessibilityIdentifier("exerciseDetails")
            let vc = UIHostingController(rootView: swiftUIView)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
