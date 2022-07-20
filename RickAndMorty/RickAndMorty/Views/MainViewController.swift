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
                                           left: cellsSpacing ,
                                           bottom: cellsSpacing,
                                           right: cellsSpacing )
        let numberOfItemsInSection = 2
        let cellWidth = (view.bounds.width
                         - cellsSpacing
                         * (CGFloat(numberOfItemsInSection) + 1)) / CGFloat(numberOfItemsInSection)
        let cellHeight = cellWidth * 1.2
        layout.minimumLineSpacing = cellsSpacing
        layout.minimumInteritemSpacing = cellsSpacing
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        let sectionHeight = CGFloat(4)
        layout.headerReferenceSize = CGSize(width: self.view.frame.size.width,
                                            height: sectionHeight)
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var loadingView: LoadingView = {
        let loading =  LoadingView()
        loading.layer.zPosition = 999
        return loading
    }()
    
    var presenter: MainPresenterProtocol!
//    var page = 1
//    var hasMoreContent = true
//    var characterCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .darkGray
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}

extension MainViewController: MainViewProtocol {
    func fetchSuccess() {
        UIView.transition(with: self.collectionView,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: {self.collectionView.reloadData()}, completion: nil)
    }
    
    func fetchFailture(error: Error) {
        print(error)
    }
    
    func showLodingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func hideLoading() {
        loadingView.removeFromSuperview()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            cell.getImageFromURL(id: String(presenter.results[indexPath.row].id))
            cell.nameLabel.text = presenter.results[indexPath.row].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
        let detailVC = DetailViewController()
        let indexPathTapped = presenter.results[indexPath.row]
        detailVC.getImageFromURL(id: String(indexPathTapped.id))
        detailVC.nameLabel.text = indexPathTapped.name
        detailVC.speciesLabel.text = indexPathTapped.species
        detailVC.genderLabel.text = indexPathTapped.gender
        detailVC.statusLabel.text = indexPathTapped.status
        detailVC.locationLabel.text = indexPathTapped.location.name
        detailVC.episodesCountLabel.text = "Number of appearances: \(indexPathTapped.episode.count)"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
