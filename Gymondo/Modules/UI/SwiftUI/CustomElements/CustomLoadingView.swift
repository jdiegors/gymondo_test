//
//  CustomLoadingView.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 21/9/23.
//

import SwiftUI

struct CustomLoadingView: ViewModifier {
    
    var isLoading: Bool
    
    init(isLoading: Bool, color: Color = .primary, lineWidth: CGFloat = 3) {
        self.isLoading = isLoading
    }

    var animatableData: Bool {
        get { isLoading }
        set { isLoading = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                GeometryReader { geometry in
                    VStack {
                        Text("Loading")
                        ProgressView()
                    }
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isLoading ? 1 : 0)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            } else {
                content
                    .padding(.all)
            }
        }
    }
}
