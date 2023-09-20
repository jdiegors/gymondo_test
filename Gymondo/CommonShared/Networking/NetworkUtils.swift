//
//  NetworkUtils.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation

enum ApiError: Error {
    case unknown
    case notFound
    case unauthorized
    case forbidden
    case badRequest
    case internalServerError
    case badGateway
    case serviceUnavailable
    case gatewayTimeOut
}

enum HttpMethod: String {
    case GET
    case POST
}
