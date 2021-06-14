//
//  PokemonController.swift
//  Pokedex
//
//  Created by Matheus Torres on 13/06/21.
//

import UIKit

class PokemonController: UIViewController {
    // MARK: - UI Properties
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var pokemonIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var pokemonTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pokedexLightGray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    convenience init(pokemon: Pokemon) {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - UI
    private func configureUI() {
        
    }
}
