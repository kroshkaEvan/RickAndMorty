//
//  CustomCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"

    lazy var iconCharacterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.addCustomLabel()
        label.font = Constants.Font.nameFont
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.addCustomLabel()
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.addCustomLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateConstraints()
        shadowDecorate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = Constants.Color.nameColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4.5
        layer.shadowOpacity = 3
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    private func activateConstraints() {
        self.backgroundColor = .darkGray
        let sizeIcon = self.bounds.height * 0.95
        [iconCharacterImageView, nameLabel, speciesLabel, genderLabel].forEach { self.addSubview($0) }
        iconCharacterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconCharacterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                        constant: 2.5).isActive = true
        iconCharacterImageView.widthAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        iconCharacterImageView.heightAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: iconCharacterImageView.trailingAnchor,
                                           constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                          constant: 10).isActive = true
        speciesLabel.leadingAnchor.constraint(equalTo: iconCharacterImageView.trailingAnchor,
                                              constant: 10).isActive = true
        speciesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor,
                                         constant: 10).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: iconCharacterImageView.trailingAnchor,
                                             constant: 10).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func getImageFromURL(id: String) {
        guard let url = URL(string: "\(Constants.Strings.URL)/character/avatar/\(id).jpeg") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.iconCharacterImageView.image = UIImage(data: data)
                }
            }
        }
        dataTask.resume()
    }
}
