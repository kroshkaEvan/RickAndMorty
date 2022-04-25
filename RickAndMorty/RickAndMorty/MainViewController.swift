//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGray
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingView: LoadingView = {
        let loading =  LoadingView()
        loading.layer.zPosition = 999
        return loading
    }()
    
    private var characters: Character?
    private var results = [Result]()
    private var characterCount = 0
    private var page = 1
    private let delay = 1
    private var hasMoreContent = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupView()
        fetchNewCharacters(page: page)
    }

    private func setupView() {
        view.backgroundColor = .darkGray
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    private func showLodingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    private func hideLoading() {
        loadingView.removeFromSuperview()
    }
    
    private func fetchNewCharacters(page: Int) {
        self.showLodingView()
        NetworkManager.shared.fetchPagesCharacters (page: page) { [weak self]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if self.results.count < self.characterCount { self.hasMoreContent = false }
                self.results += response.results
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(self.delay), execute: { () -> Void in
                    self.tableView.reloadData()
                    self.hideLoading()
                })
            case .failure(_):
                return
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath)
        if let cell = cell as? CustomTableViewCell {
            cell.getImageFromURL(id: String(results[indexPath.row].id))
            cell.nameLabel.text = results[indexPath.row].name
            cell.speciesLabel.text = results[indexPath.row].species
            switch cell.speciesLabel.text {
            case "Alien" :  cell.speciesLabel.textColor = .green
            case "Humanoid" : cell.speciesLabel.textColor = .cyan
            case "Human" : cell.speciesLabel.textColor = .yellow
            case "unknown" : cell.speciesLabel.textColor = .white
            default : cell.speciesLabel.textColor = .brown
            }
            cell.genderLabel.text = results[indexPath.row].gender
            switch cell.genderLabel.text {
            case "Male" : cell.genderLabel.textColor = .blue
            case "Female" : cell.genderLabel.textColor = .systemPink
            default : cell.genderLabel.textColor = .white
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        let indexPathTapped = self.results[indexPath.row]
        detailVC.getImageFromURL(id: String(indexPathTapped.id))
        detailVC.nameLabel.text = indexPathTapped.name
        detailVC.speciesLabel.text = indexPathTapped.species
        detailVC.genderLabel.text = indexPathTapped.gender
        detailVC.statusLabel.text = indexPathTapped.status
        detailVC.locationLabel.text = indexPathTapped.location.name
        let navigationVc = UINavigationController(rootViewController: detailVC)
        navigationVc.modalPresentationStyle = .fullScreen
        navigationVc.navigationBar.tintColor = .darkGray
        self.present(navigationVc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentHeight = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        let height = scrollView.height
        if contentOffsetY > contentHeight - height {
            guard hasMoreContent else { return }
            self.page += 1
            fetchNewCharacters(page: page)
        }
    }
}
