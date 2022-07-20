//
//  Builder.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 20.07.22.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view,
                                      networkManager: networkManager)
        view.presenter = presenter
        return view
    }
}
