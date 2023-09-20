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
    private var viewModel: ExerciseListViewModelImpl!
    private var mockNetworkClient: MockNetworkClient!
    private var cancellables: Set<AnyCancellable> = []
    private var wgerNetworkClient: WgerNetworkClient!
    private var imageNetworkClient: ImageNetworkClient!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        imageNetworkClient = ImageNetworkClient(networkClient: mockNetworkClient)
        viewModel = ExerciseListViewModelImpl(networkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient)
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        viewModel = nil
        mockNetworkClient = nil
        wgerNetworkClient = nil
        imageNetworkClient = nil
    }

    func testGetExerciseListViewModel() {
        viewModel.getExercises()
        XCTAssertGreaterThan(viewModel.exercisesList.count, 0)
    }

}
