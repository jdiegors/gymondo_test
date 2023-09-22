//
//  ExerciseDetailsViewTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 22/9/23.
//

import XCTest
@testable import Gymondo
import SwiftUI

final class ExerciseDetailsViewTest: XCTestCase {
    private var sut: ExerciseDetailsView<MockExerciseDetailsViewModelImpl>!
    private var viewModel: MockExerciseDetailsViewModelImpl!
    let imageModel = ImageModel(id: nil,
                                uuid: nil,
                                exerciseBase: nil,
                                exerciseBaseUUID: nil,
                                image: "http://google.com",
                                isMain: true,
                                style: nil,
                                license: nil,
                                licenseTitle: nil,
                                licenseObjectURL: nil,
                                licenseAuthor: nil,
                                licenseAuthorURL: nil,
                                licenseDerivativeSourceURL: nil,
                                authorHistory: nil)

    override func setUpWithError() throws {
        viewModel = MockExerciseDetailsViewModelImpl()
        sut = ExerciseDetailsView(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
    }

    func test_getExerciseData() throws {
        let data = sut.viewModel.getExerciseData(exercises: [])
        
        XCTAssertEqual(viewModel.getExerciseDataCount, 1)
        XCTAssertEqual(viewModel.name, "Name")
        XCTAssertEqual(viewModel.description, "Description")
        XCTAssertEqual(data.id, 1)
        XCTAssertEqual(data.name, "Name")
        XCTAssertEqual(data.description, "Description")
    }
    
    func test_getImageUrl() throws {
        let url = sut.viewModel.getImageUrl(image: imageModel)
        
        XCTAssertEqual(viewModel.getImageUrlCount, 1)
        XCTAssertEqual("https://google.com", url.absoluteString)
    }
    
    func test_getMainImageUrl() throws {
        let url = sut.viewModel.getMainImageUrl(images: [imageModel])
        
        XCTAssertEqual(viewModel.getMainImageUrlCount, 1)
        XCTAssertEqual("https://google.com", url!.absoluteString)
    }
    
    func test_pushVariation() throws {
        sut.viewModel.pushVariation(exerciseId: 1)
        
        XCTAssertEqual(viewModel.pushVariationCount, 1)
    }
    
    private class MockExerciseDetailsViewModelImpl: ExerciseDetailsViewModel {
        var name: String = ""
        var description: String = ""
        var images: [ImageModel] = []
        var exerciseVariations: ExercisesVariation = []
        var isLoading: Bool = false
        
        var getExerciseDataCount = 0
        var getImageUrlCount = 0
        var getMainImageUrlCount = 0
        var pushVariationCount = 0
        
        func getExerciseData(exercises: [Gymondo.ExerciseElement]?) -> (id: Int, name: String, description: String) {
            getExerciseDataCount += 1
            self.name = "Name"
            self.description = "Description"
            return (1, "Name", "Description")
        }
        
        func getImageUrl(image: ImageModel) -> URL {
            getImageUrlCount += 1
            return URL(string: "https://google.com")!
        }
        
        func getMainImageUrl(images: [ImageModel]?) -> URL? {
            getMainImageUrlCount += 1
            return URL(string: "https://google.com")!
        }
        
        func pushVariation(exerciseId: Int?) {
            pushVariationCount += 1
        }
    }
}
