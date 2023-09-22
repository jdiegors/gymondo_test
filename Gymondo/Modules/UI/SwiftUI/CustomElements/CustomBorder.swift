//
//  CustomBorder.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 21/9/23.
//

import SwiftUI

struct CustomBorder: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .foregroundColor(Color.clear)
                .contentShape(Rectangle())
            
            content
                .padding(.all)
        }
    }
}
