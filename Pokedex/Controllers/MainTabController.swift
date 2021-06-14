//
//  MainTabController.swift
//  Pokedex
//
//  Created by Matheus Torres on 10/06/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    // MARK: - UI
    
    private func configureTabBarController() {
        view.backgroundColor = .white
        tabBar.tintColor = .pokedexRed
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let pokedexController = createNavigationController(title: "Pokedex",
                                                           image: UIImage(named: "pokeIcon")!,
                                                           rootViewController: PokedexController())
        
        let cardsController = createNavigationController(title: "TCG Cards",
                                                         image: UIImage(systemName: "creditcard.fill")!,
                                                         rootViewController: CardsController())
        
        let profileController = createNavigationController(title: "Profile",
                                                           image: UIImage(systemName: "person.fill")!,
                                                           rootViewController: ProfileController())
        
        viewControllers = [pokedexController, cardsController, profileController]
    }
    
    private func createNavigationController(title: String, image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nav
    }
}
