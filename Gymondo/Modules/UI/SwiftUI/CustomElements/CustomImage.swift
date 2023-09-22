//
//  CustomImage.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import SwiftUI

struct CustomImage: View {
    @State var imageURL: URL
    
    var body: some View {
        AsyncImage(url: imageURL) { result in
            switch result {
            case .empty:
                ZStack {
                    Image("default-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 2 - 5, height: 200)
                    ProgressView()
                }
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(maxWidth: UIScreen.main.bounds.width - 20, maxHeight: 200)
            case .failure:
                Image("default-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 2 - 5, height: 200)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(imageURL: URL(string: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-model-unselect-gallery-1-202309?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1693010533609")!)
    }
}
