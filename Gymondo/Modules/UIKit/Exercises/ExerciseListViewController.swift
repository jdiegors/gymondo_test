//
//  ExerciseListViewController.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import UIKit
import SwiftUI

class ExerciseListViewController: UIViewController, ExerciseListViewModelConsumer {
    private let viewModel: ExerciseListViewModel

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: (UIScreen.main.bounds.width / 2) - 10, height: 200)
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    
    init(viewModel: ExerciseListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setViewModelConsumer(viewModelConsumer: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.title = "Exercises"
    }
    
    func setupTableView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ExerciseCollectionViewCell.self))
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func updateTableView() {
        collectionView.reloadData()
    }
}

extension ExerciseListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.exercisesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExerciseCollectionViewCell.self), for: indexPath) as! ExerciseCollectionViewCell
        
        cell.configure(with: viewModel.getExerciseCollectionViewModel())
        
        let data = viewModel.exercisesList[indexPath.row]
        cell.images = data.images
        cell.exercises = data.exercises
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.exercisesList[indexPath.row]
        if let exerciseId = data.id,
           let vm = viewModel.initializeExerciseDetails(exerciseId: exerciseId) {
            let swiftUIView = ExerciseDetailsView(viewModel: vm)
            let vc = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
