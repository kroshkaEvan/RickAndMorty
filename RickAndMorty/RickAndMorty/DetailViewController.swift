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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGray
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back".localizated(),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapBack))
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
        let sizeIcon = CGFloat(220)
        [iconCharacterImageView, nameLabel, speciesLabel, genderLabel, statusLabel, locationLabel, tableView].forEach { contentView.addSubview($0) }
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
                                                    multiplier: 0.8).isActive = true
        speciesLabel.setupUI(view: contentView, top: nameLabel)
        genderLabel.setupUI(view: contentView, top: speciesLabel)
        statusLabel.setupUI(view: contentView, top: genderLabel)
        locationLabel.setupUI(view: contentView, top: statusLabel)
        tableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,
                                       constant: distanceY).isActive = true
        tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: contentView.widthAnchor,
                                                    multiplier: 0.6).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -distanceY).isActive = true
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
    
    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
}
