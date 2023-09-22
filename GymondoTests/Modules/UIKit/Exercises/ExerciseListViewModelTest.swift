//
//  ExerciseListViewModelTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import XCTest
import Combine
@testable import Gymondo

final class ExerciseListViewModelTest: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var sut: ExerciseListViewModelImpl!
    private var mockNetworkClient: MockNetworkClient!
    private var wgerNetworkClient: WgerNetworkClient!
    private var imageNetworkClient: ImageNetworkClient!
    private var coordinator: MainCoordinator!
    
    override func setUpWithError() throws {
        super.setUp()
        
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        imageNetworkClient = ImageNetworkClient(networkClient: mockNetworkClient)
        coordinator = MainCoordinator(navigationController: UINavigationController())
        sut = ExerciseListViewModelImpl(wgerNetworkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient, coordinator: coordinator)
    }
    
    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
        sut = nil
        mockNetworkClient = nil
        wgerNetworkClient = nil
        imageNetworkClient = nil
    }

    func test_GetExerciseList() {
        XCTAssertGreaterThan(sut.exercisesList.count, 0)
    }

}
