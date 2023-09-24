//
//  ExerciseDetailsView.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 20/9/23.
//

import SwiftUI

struct ExerciseDetailsView<T>: View where T: ExerciseDetailsViewModel {
    @ObservedObject var viewModel: T
    @State var redirect: Bool = false
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Text(viewModel.name)
                    .font(.title)
                
                Group {
                    HStack {
                        Text("Description")
                            .font(.title)
                            .padding(.top)
                        Spacer()
                    }
                    Text(viewModel.description)
                        .font(.body)
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images, id: \.uuid) { img in
                            CustomImage(imageURL: viewModel.getImageUrl(image: img))
                        }
                    }
                }
                .padding(.top)
                
                if viewModel.exerciseVariations.count > 0{
                    Group {
                        HStack {
                            Text("Variations")
                                .font(.title)
                                .padding(.top)
                            Spacer()
                        }
                    }
                    
                    Group {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.exerciseVariations, id: \.uuid) { variation in
                                    let variationExercise = viewModel.getExerciseData(exercises: variation.exercises)
                                    Variation(name: variationExercise.name,
                                              imageURL: viewModel.getMainImageUrl(images: variation.images))
                                    .modifier(CustomBorder())
                                    .onTapGesture {
                                        viewModel.pushVariation(exerciseId: variation.id)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        .accessibilityIdentifier("variations")
                    }
                }
            }
        }
        .navigationTitle(viewModel.name)
        .modifier(CustomLoadingView(isLoading: viewModel.isLoading))
    }
}

#if DEBUG
struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let mainCoordinagor = MainCoordinator(navigationController: UINavigationController())
        let networClient = NetworkClient()
        let wgerNetworkClient = WgerNetworkClient(networkClient: networClient)
        let imageNetworkClient = ImageNetworkClient(networkClient: networClient)
        let vm = ExerciseDetailsViewModelImpl(exerciseId: 1,
                                              wgerNetworkClient: wgerNetworkClient,
                                              imageNetworkClient: imageNetworkClient,
                                              coordinator: mainCoordinagor)
        ExerciseDetailsView(viewModel: vm)
    }
}
#endif
