//
//  ExerciseCollectionViewCellTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 22/9/23.
//

import XCTest
@testable import Gymondo

final class ExerciseCollectionViewCellTest: XCTestCase {
    private var sut: ExerciseCollectionViewCell!
    private var viewModel: MockExerciseCollectionViewModelImpl!

    override func setUpWithError() throws {
        sut = ExerciseCollectionViewCell()
        viewModel = MockExerciseCollectionViewModelImpl()
        
        sut.configure(with: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getImage() throws {
        sut.images = []
        
        XCTAssertEqual(viewModel.getImageCount, 1)
    }
    
    func test_getName() throws {
        sut.exercises = []
        
        XCTAssertEqual(viewModel.getNameCount, 1)
    }

    private class MockExerciseCollectionViewModelImpl: ExerciseCollectionViewModel {
        
        
        var getImageCount = 0
        var getNameCount = 0
        
        func getImage(images: [ImageModel]?, completion: @escaping (UIImage) -> Void) {
            getImageCount += 1
        }
        
        func getName(exercises: [ExerciseElement]?) -> String {
            getNameCount += 1
            return ""
        }
    }
}
