//
//  MainTabBarController.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 28.04.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        UITabBar.appearance().barTintColor = .darkGray
        setupVCs()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let scalingRatio = CGFloat(1.2)
        let propertyAnimator = UIViewPropertyAnimator(duration: 1,
                                                      dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: scalingRatio,
                                                                        y: scalingRatio)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity},
                                       delayFactor: CGFloat(0.3))
        propertyAnimator.startAnimation()
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?,
                                     selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        rootViewController.navigationItem.title = title
        if let font = Constants.Font.customDescriptionFont {
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        return navController
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: MainViewController(),
                                   title: "Characters",
                                   image: Constants.Icon.iconBlackPurple,
                                   selectedImage: Constants.Icon.iconPurple),
            createNavController(for: LocationViewController(),
                                   title: "Locations",
                                   image: Constants.Icon.iconBlackBlue,
                                   selectedImage: Constants.Icon.iconBlue),
            createNavController(for: EpisodeViewController(),
                                   title: "Episodes",
                                   image: Constants.Icon.iconBlackRed,
                                   selectedImage: Constants.Icon.iconRed)
        ]
    }
}

