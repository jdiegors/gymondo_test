//
//  Variation.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import SwiftUI

struct Variation: View {
    
    @State var name: String
    @State var imageURL: URL?
    
    var body: some View {
        VStack {
            if let imageURL = imageURL {
                CustomImage(imageURL: imageURL)
            } else {
                Image("default-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
            Text(name)
                .font(.subheadline)
        }
    }
}

#if DEBUG
struct Variation_Previews: PreviewProvider {
    static var previews: some View {
        
        Variation(name: "Name", imageURL: URL(string: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-model-unselect-gallery-1-202309?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1693010533609")!)
    }
}
#endif
