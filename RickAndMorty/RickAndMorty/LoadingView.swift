//
//  LoadingView.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 25.04.22.
//

import UIKit

class LoadingView: UIView {
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(blurEffectView)
        self.addSubview(loadingActivityIndicator)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
