//
//  ExerciseCollectionViewModelTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 22/9/23.
//

import XCTest
@testable import Gymondo
import Combine

final class ExerciseCollectionViewModelTest: XCTestCase {
    private var sut: ExerciseCollectionViewModel!
    private var mockImageNetwork: MockImageNetworkClient!
    private var expectation: XCTestExpectation!
    
    let imageModel = ImageModel(id: nil,
                                uuid: nil,
                                exerciseBase: nil,
                                exerciseBaseUUID: nil,
                                image: "https://google.com",
                                isMain: true,
                                style: nil,
                                license: nil,
                                licenseTitle: nil,
                                licenseObjectURL: nil,
                                licenseAuthor: nil,
                                licenseAuthorURL: nil,
                                licenseDerivativeSourceURL: nil,
                                authorHistory: nil)
    
    let exerciseElement = ExerciseElement(id: nil,
                                          uuid: nil,
                                          name: "Name",
                                          exerciseBase: nil,
                                          description: nil,
                                          created: nil,
                                          creationDate: nil,
                                          language: nil,
                                          notes: nil,
                                          aliases: nil,
                                          license: nil,
                                          licenseTitle: nil,
                                          licenseObjectURL: nil,
                                          licenseAuthor: nil,
                                          licenseAuthorURL: nil,
                                          licenseDerivativeSourceURL: nil,
                                          authorHistory: nil)

    override func setUpWithError() throws {
        mockImageNetwork = MockImageNetworkClient()
        sut = ExerciseCollectionViewModelImpl(imageNetworkClient: mockImageNetwork)
        expectation = XCTestExpectation(description: "ExerciseCollectionView Expectation")
    }

    override func tearDownWithError() throws {
        sut = nil
        mockImageNetwork = nil
        expectation = nil
    }
    
    func test_getImage() throws {
        var image: UIImage? = nil
        sut.getImage(images: [imageModel], completion: { i in
            image = i
            
            self.expectation.fulfill()
        })
        
        XCTAssertNotNil(image)
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_getName() throws {
        let name = sut.getName(exercises: [exerciseElement])
        
        XCTAssertEqual(name, "Name")
    }
    
    private class MockImageNetworkClient: ImageNetworkProvider {
        func getImage(path: String?) -> AnyPublisher<UIImage, Error> {
            let image = UIImage(named: "default-placeholder")!
            return Just(image)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
