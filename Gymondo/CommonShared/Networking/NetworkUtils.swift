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
    
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .notFound:
            return "Not Found"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .badRequest:
            return "Bad Request"
        case .internalServerError:
            return "Internal Server Error"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeOut:
            return "Gateway Time Out"
        }
    }
}

enum HttpMethod: String {
    case GET
    case POST
}
