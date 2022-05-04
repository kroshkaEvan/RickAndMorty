//
//  Constants.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import Foundation
import UIKit

class Constants {
    class Strings {
        static let URL = "https://rickandmortyapi.com/api"
        static let imageURL = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    }
    
    class Font {
        static let customFont = UIFont(name: "Samson",
                             size: 20)
        static let nameFont = UIFont(name: "get schwifty",
                             size: 24)
        static let customDescriptionFont = UIFont(name: "Samson",
                             size: 24)
        static let nameDescriptionFont = UIFont(name: "get schwifty",
                             size: 30)
    }
    
    class Color {
        static let nameColor = UIColor(red: 99 / 255,
                                       green: 210 / 255,
                                       blue: 166 / 255,
                                       alpha: 1)
    }
}
