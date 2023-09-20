//
//  ImageRouter.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation

enum ImageRouter: APIBuilder {
    case image(path: String?)
    
    var url: String {
        switch self{
        case .image(let path):
            return path ?? ""
        }
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var body: [String : Any]? {
        nil
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}
