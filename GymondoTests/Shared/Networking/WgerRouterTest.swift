//
//  WgerRouterTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import XCTest
import Combine
@testable import Gymondo

final class WgerRouterTest: XCTestCase {
    private var mockNetworkClient: MockNetworkClient!
    private var cancellables: Set<AnyCancellable> = []
    private var wgerNetworkClient: WgerNetworkClient!
    private var expectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        super.setUp()
        expectation = expectation(description: "Parse the exercises")
    }
    
    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
        mockNetworkClient = nil
        wgerNetworkClient = nil
        expectation = nil
    }

    func test_WgerNetworkProvider_GetExercises() {
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        
        wgerNetworkClient.getExercises()
            .sink { _ in } receiveValue: { exercises in
                let count = exercises.count
                let result = exercises.results?.count
                
                XCTAssertNotNil(count)
                XCTAssertGreaterThan(count ?? -1, 0)
                XCTAssertGreaterThan(result ?? -1, 0)
                
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_WgerNetworkProvider_GetExerciseDetail() {
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise_detail.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        
        wgerNetworkClient.getDetails(exerciseId: 9)
            .sink { _ in } receiveValue: { detail in
                let exerciseId = detail.id
                
                XCTAssertEqual(exerciseId ?? 0, 9)
                
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_WgerNetworkProvider_GetExerciseVariation() {
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise_variation.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        
        wgerNetworkClient.getVariations(variation: 47)
            .sink { _ in } receiveValue: { variations in
                let count = variations.count
                let result = variations.results?.count
                
                XCTAssertNotNil(count)
                XCTAssertGreaterThan(count ?? -1, 0)
                XCTAssertGreaterThan(result ?? -1, 0)
                
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.5)
    }
}
