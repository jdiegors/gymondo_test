//
//  ImageNetworkProvider.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import UIKit
import Combine

protocol ImageNetworkProvider: AnyObject {
    func getImage(path: String?) -> AnyPublisher<UIImage, Error>
}

class ImageNetworkClient: ImageNetworkProvider {
    var networkClient: NetworkProvider
    
    init(networkClient: NetworkProvider) {
        self.networkClient = networkClient
    }
    
    func getImage(path: String?) -> AnyPublisher<UIImage, Error> {
        networkClient.request(from: ImageRouter.image(path: path)).image()
    }
}
