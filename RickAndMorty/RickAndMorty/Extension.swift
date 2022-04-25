//
//  Extension.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import Foundation
import UIKit

extension UILabel {
    func addDescriptionLabel() {
        font = Constants.Font.customFont
        textColor = Constants.Color.nameColor
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
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
