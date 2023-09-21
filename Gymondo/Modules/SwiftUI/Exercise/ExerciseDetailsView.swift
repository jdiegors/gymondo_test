//
//  ExerciseDetailsView.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import SwiftUI

protocol ExerciseDetailsViewFactory {
    func initializeExerciseDetails(exerciseId: Int) -> ExerciseDetailsViewModelImpl?
}

struct ExerciseDetailsView<T>: View where T: ExerciseDetailsViewModel {
    @ObservedObject var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Text(viewModel.name)
                    .font(.title)
                
                Group {
                    Text("Description")
                        .font(.title)
                        .padding(.top)
                    Text(viewModel.description)
                        .font(.body)
                }
                
                ForEach(viewModel.images, id: \.uuid) { img in
                    AsyncImage(url: viewModel.getImageUrl(image: img)) { result in
                        switch result {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 200)
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.name)
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}

#if DEBUG
struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let networClient = NetworkClient()
        let wgerNetworkClient = WgerNetworkClient(networkClient: networClient)
        let imageNetworkClient = ImageNetworkClient(networkClient: networClient)
        let vm = ExerciseDetailsViewModelImpl(exerciseId: 1, wgerNetworkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient)
        ExerciseDetailsView(viewModel: vm)
    }
}
#endif
