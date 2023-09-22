//
//  ExerciseListViewControllerTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 22/9/23.
//

import XCTest
@testable import Gymondo

final class ExerciseListViewControllerTest: XCTestCase {
    private var sut: ExerciseListViewController!
    private var coordinator: MainCoordinator!
    private var viewModel: MockExerciseListViewModelImpl!

    override func setUpWithError() throws {
        super.setUp()
        
        coordinator = MainCoordinator(navigationController: UINavigationController())
        viewModel = MockExerciseListViewModelImpl()
        
        sut = ExerciseListViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        
        sut = nil
        coordinator = nil
    }

    func test_ExcerseListViewControllerInit() throws {
        XCTAssertNotNil(sut.viewModel)
        XCTAssertEqual(viewModel.setViewModelConsumerCount, 1)
    }
    
    func test_ExcerseListViewController_GetExerciseColletionViewModel() throws {
        _ = sut.viewModel.getExerciseCollectionViewModel()
        XCTAssertEqual(viewModel.getExerciseCollectionViewModelCount, 1)
    }
    
    private class MockExerciseListViewModelImpl: ExerciseListViewModel {
        var isLoading: Bool = true
        var exercisesList: Exercises = []
        var coordinator: MainCoordinator = MainCoordinator(navigationController: UINavigationController())
        
        var setViewModelConsumerCount = 0
        var getExerciseCollectionViewModelCount = 0
        
        func setViewModelConsumer(viewModelConsumer: ExerciseListViewModelConsumer?) {
            setViewModelConsumerCount += 1
        }
        
        func getExerciseCollectionViewModel() -> ExerciseCollectionViewModel {
            getExerciseCollectionViewModelCount += 1
            return ExerciseCollectionViewModelImpl(imageNetworkClient: ImageNetworkClient(networkClient: NetworkClient()))
        }
    }
}
