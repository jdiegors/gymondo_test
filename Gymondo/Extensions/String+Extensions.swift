//
//  String+Extensions.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import Foundation

extension String{
    var removeHtmlTags : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
