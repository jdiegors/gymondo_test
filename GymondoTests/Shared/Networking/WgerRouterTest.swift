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
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        mockNetworkClient = nil
        wgerNetworkClient = nil
    }

    func testWgerNetworkProviderGetExercises() {
        let exp = expectation(description: "Parse the exercises")
        
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        
        wgerNetworkClient.getExercises()
            .sink { _ in } receiveValue: { exercises in
                let count = exercises.count
                let result = exercises.results?.count
                
                XCTAssertNotNil(count)
                XCTAssertGreaterThan(count ?? -1, 0)
                XCTAssertGreaterThan(result ?? -1, 0)
                
                exp.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 0.5)
    }

}
