//
//  UIImageView+Extensions.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import UIKit

extension UIImageView {
    func roundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
