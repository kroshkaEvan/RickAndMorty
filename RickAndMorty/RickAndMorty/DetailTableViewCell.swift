//
//  DetailTableViewCell.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 26.04.22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    static let identifier = "DetailTableViewCell"
    
    lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.addCustomLabel()
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
        self.backgroundColor = .white
        self.addSubview(episodeLabel)
        episodeLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: 5).isActive = true
        episodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        episodeLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        episodeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
