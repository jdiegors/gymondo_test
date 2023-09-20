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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWgerNetworkProviderGetExercises() {
        let exp = expectation(description: "Parse the exercises")
        var subscription = Set<AnyCancellable>()
        
        let networkClient = TestUtils.mockNetworkClient(file: "exercise.json")
        let wgerNetworkClient = WgerNetworkClient(networkClient: networkClient)
        
        wgerNetworkClient.getExercises()
            .sink { _ in } receiveValue: { exercises in
                let count = exercises.count
                
                XCTAssertNotNil(count)
                XCTAssertGreaterThan(count ?? -1, 0)
                
                exp.fulfill()
            }
            .store(in: &subscription)
        
        wait(for: [exp], timeout: 0.5)
    }

}
