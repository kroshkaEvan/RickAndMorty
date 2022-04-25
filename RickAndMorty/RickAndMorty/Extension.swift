//
//  Extension.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import Foundation
import UIKit

extension UILabel {
    func addCustomLabel() {
        font = Constants.Font.customFont
        textColor = Constants.Color.nameColor
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addDescriptionLabel() {
        textColor = .lightGray
        textAlignment = .left
        font = .systemFont(ofSize: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupUI(view: UIView, top: UILabel) {
        topAnchor.constraint(equalTo: top.bottomAnchor,
                             constant: 10).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor,
                               multiplier: 0.8).isActive = true
    }
}

extension UIView {
    var width: CGFloat{
        return self.frame.size.width
    }
    
    var height: CGFloat{
        return self.frame.size.height
    }
}

extension String {
    func localizated() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
