//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellsSpacing = CGFloat(10)
        layout.sectionInset = UIEdgeInsets(top: cellsSpacing ,
                                           left: cellsSpacing / 2,
                                           bottom: cellsSpacing,
                                           right: cellsSpacing / 2)
        let cellWidth = (view.bounds.width
                         - layout.sectionInset.left
                         - layout.sectionInset.right
                         - cellsSpacing)
        let cellHeight = cellWidth / 2.4
        layout.minimumLineSpacing = cellsSpacing
        layout.minimumInteritemSpacing = cellsSpacing
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let sectionHeight = CGFloat(4)
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width,
                                            height: sectionHeight)
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
        fetchNewCharacters(page: page)
    }

    private func setupView() {
        view.backgroundColor = .darkGray
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    private func showLodingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
                    self.collectionView.reloadData()
                    self.hideLoading()
                })
            case .failure(_):
                return
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? CustomCollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
        let detailVC = DetailViewController()
        let indexPathTapped = self.results[indexPath.row]
        detailVC.getImageFromURL(id: String(indexPathTapped.id))
        detailVC.nameLabel.text = indexPathTapped.name
        detailVC.speciesLabel.text = indexPathTapped.species
        detailVC.genderLabel.text = indexPathTapped.gender
        detailVC.statusLabel.text = indexPathTapped.status
        detailVC.locationLabel.text = indexPathTapped.location.name
        detailVC.episodesCountLabel.text = "Number of appearances: \(indexPathTapped.episode.count)"
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
