//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 20.07.22.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func fetchSuccess()
    func fetchFailture(error: Error)
    func showLodingView()
    func hideLoading()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol,
         networkManager: NetworkManagerProtocol)
    
    var characters: Character? { get set }
    
    var results: [Result] { get set }
    
//    var page: Int { get set }
//    var hasMoreContent: Bool { get set }
//    var characterCount: Int { get set }
    
    func fetchNewCharacters(page: Int)
}

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let networkManager: NetworkManagerProtocol?
    var characters: Character?
    var results = [Result]()
    
    var pages = 5
    
    let delay = 1
    
    required init(view: MainViewProtocol,
                  networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        for page in 1...pages {
            fetchNewCharacters(page: page)
        }
    }
    
    func fetchNewCharacters(page: Int) {
        view?.showLodingView()
        NetworkManager.shared.fetchPagesCharacters(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.results += response.results
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(self.delay), execute: { () -> Void in
                    self.view?.hideLoading()
                })
            case .failure(_):
                return
            }
        }
    }
}
