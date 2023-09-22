//
//  ExerciseTableViewCell.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    private var viewModel: ExerciseCollectionViewModel?
    
    var image: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "default-placeholder")
        i.contentMode = .scaleAspectFill
        i.roundedCorners(radius: 20)
        return i
    }()
    
    var name: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        return lbl
    }()
    
    var images: [ImageModel]? {
        didSet {
            viewModel?.getImage(images: images, completion: { [weak self] img in
                guard let self = self else { return }
                self.image.image = img
            })
        }
    }
    
    var exercises: [ExerciseElement]? {
        didSet {
            self.name.text = viewModel?.getName(exercises: exercises)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = UIImage(named: "default-placeholder")
        self.images = nil
        self.name.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(image)
        self.addSubview(name)
        setupImage()
        setupName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ExerciseCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupName() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
