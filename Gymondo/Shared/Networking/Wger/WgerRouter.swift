//
//  WgerRouter.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation

enum WgerRouter: APIBuilder {
    case exercise
    case exerciseDetail(id: Int)
    case exerciseVariation(variation: Int)
    
    var endpoint: String {
        "https://wger.de/api/v2"
    }
    
    var path: String {
        switch self {
        case .exercise:
            return "exercisebaseinfo"
        case .exerciseDetail(let id):
            return "exercisebaseinfo/\(id)"
        case .exerciseVariation(let variation):
            return "exercisebaseinfo/?variations=\(variation)"
        }
    }
    
    var url: String {
        "\(endpoint)/\(path)"
    }
    
    var body: [String : Any]? {
        switch self {
        default: return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        default: return .GET
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        if let parameters = pametersConvert(parameters: self.body) {
            request.httpBody = parameters
        }
        self.headers?.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        return request
    }
    
    private func pametersConvert(parameters: [String: Any]?) -> Data? {
        do {
            guard let parameters = parameters else {
                return nil
            }
            return try JSONSerialization.data(withJSONObject: parameters as [String: Any])
        }catch _ {
            return nil
        }
    }
}
