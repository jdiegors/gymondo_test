//
//  NetworkProvider.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import Combine

protocol NetworkProvider: AnyObject {
    func request(from endPoint: APIBuilder) -> AnyPublisher<Data, Error>
}

protocol APIBuilder {
    var urlRequest: URLRequest? { get }
    var url: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    var method: HttpMethod { get }
}
