//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 25.04.22.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconCharacterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        label.font = Constants.Font.nameDescriptionFont
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
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        return label
    }()
    
    lazy var episodesCountLabel: UILabel = {
        let label = UILabel()
        label.addDescriptionLabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapBack))
        navigationItem.leftBarButtonItem?.tintColor = Constants.Color.nameColor
        setupScrollView()
        setupUI()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupUI() {
        let distanceY = CGFloat(10)
        let sizeIcon = view.bounds.width * 0.8
        [iconCharacterImageView, nameLabel, speciesLabel, genderLabel, statusLabel, locationLabel, episodesCountLabel].forEach { contentView.addSubview($0) }
        iconCharacterImageView.layer.cornerRadius = sizeIcon / 2
        iconCharacterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                    constant: 50).isActive = true
        iconCharacterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        iconCharacterImageView.widthAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        iconCharacterImageView.heightAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        nameLabel.topAnchor.constraint(equalTo: iconCharacterImageView.bottomAnchor,
                                       constant: distanceY).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                         multiplier: 0.9).isActive = true
        speciesLabel.setupUI(view: contentView, top: nameLabel)
        genderLabel.setupUI(view: contentView, top: speciesLabel)
        statusLabel.setupUI(view: contentView, top: genderLabel)
        locationLabel.setupUI(view: contentView, top: statusLabel)
        episodesCountLabel.setupUI(view: contentView, top: locationLabel)
        episodesCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -distanceY).isActive = true
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
    
    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
}
