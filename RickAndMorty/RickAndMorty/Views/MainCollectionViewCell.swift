//
//  CustomCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateConstraints()
        shadowDecorate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateCell(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateCell(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateCell(isHighlighted: false)
    }
    
    private func animateCell(isHighlighted: Bool,
                         completion: ((Bool) -> Void)?=nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0.3,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .init(scaleX: 0.92, y: 0.92)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .identity
            }, completion: completion)
        }
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
        let sizeIcon = self.bounds.width * 0.95
        [iconCharacterImageView, nameLabel].forEach { self.addSubview($0) }
        iconCharacterImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                    constant: 5).isActive = true
        iconCharacterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconCharacterImageView.widthAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        iconCharacterImageView.heightAnchor.constraint(equalToConstant: sizeIcon).isActive = true
        nameLabel.topAnchor.constraint(equalTo: iconCharacterImageView.bottomAnchor,
                                       constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: 2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
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

