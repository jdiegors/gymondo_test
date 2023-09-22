//
//  ExerciseDetailsViewModelTest.swift
//  GymondoTests
//
//  Created by Juan Diego Rodriguez Steller on 21/9/23.
//

import XCTest
import Combine
@testable import Gymondo

final class ExerciseDetailsViewModelTest: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    private var sut: ExerciseDetailsViewModelImpl!
    private var mockNetworkClient: MockNetworkClient!
    private var wgerNetworkClient: WgerNetworkClient!
    private var imageNetworkClient: ImageNetworkClient!
    private var coordinator: MainCoordinator!
    
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
        super.setUp()
        
        mockNetworkClient = TestUtils.mockNetworkClient(file: "exercise_detail.json")
        wgerNetworkClient = WgerNetworkClient(networkClient: mockNetworkClient)
        imageNetworkClient = ImageNetworkClient(networkClient: mockNetworkClient)
        coordinator = MainCoordinator(navigationController: UINavigationController())
        sut = ExerciseDetailsViewModelImpl(exerciseId: 9, wgerNetworkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient, coordinator: coordinator)
    }
    
    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
        sut = nil
        mockNetworkClient = nil
        wgerNetworkClient = nil
        imageNetworkClient = nil
        coordinator = nil
    }
    
    func test_GetImageURL() throws {
        let mockedImageUrl = sut.getImageUrl(image: imageModel)
        
        XCTAssertEqual("http://google.com", mockedImageUrl.absoluteString)
    }
    
    func test_GetMainImageURL() throws {
        let mockedImageUrl = sut.getMainImageUrl(images: [imageModel])
        
        XCTAssertEqual("http://google.com", mockedImageUrl!.absoluteString)
    }
}
