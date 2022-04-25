//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"

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
        label.addDescriptionLabel()
        label.font = Constants.Font.nameFont
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func activateConstraints() {
        self.backgroundColor = .darkGray
        [iconCharacterImageView, nameLabel, speciesLabel, genderLabel].forEach { self.addSubview($0) }
        iconCharacterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconCharacterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                        constant: 10).isActive = true
        iconCharacterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconCharacterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
        let url: URL = URL(string: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg")!

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

