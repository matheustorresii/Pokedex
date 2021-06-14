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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pokemonTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var abilitiesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    convenience init(pokemon: Pokemon) {
        self.init(nibName: nil, bundle: nil)
        setupWith(pokemon: pokemon)
    }
    
    private func setupWith(pokemon: Pokemon) {
        let formattedID = String(format: "%03d", pokemon.id)
        pokemonImage.kf.setImage(with:URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(formattedID).png")!,
                                 placeholder: UIImage(named: "pokeIcon")!)
        pokemonIdLabel.text = "#\(formattedID)"
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonTitleLabel.text = pokemon.genera[7].genus // 7 - English
        configureAbilitiesLabelText(pokemon.abilities)
        heightLabel.attributedText = NSMutableAttributedString.attributeStringWith(title: "Height: ",
                                                                                   description: "\(pokemon.height)",
                                                                                   size: 20)
        weightLabel.attributedText = NSMutableAttributedString.attributeStringWith(title: "Width: ",
                                                                                   description: "\(pokemon.weight)",
                                                                                   size: 20)
    }
    
    private func configureAbilitiesLabelText(_ abilities: [String]) {
        var finalString = ""
        abilities.forEach { finalString.append("\($0.capitalized), ") }
        finalString.removeLast(2)
        abilitiesLabel.attributedText = NSMutableAttributedString.attributeStringWith(title: "Abilities: ",
                                                                                      description: finalString,
                                                                                      size: 20)
    }
}

// MARK: - UISetup
extension PokemonController: UISetup {
    func configureUI() {
        navigationController?.navigationBar.tintColor = .pokedexRed
        configureViews()
    }
    
    func configureViews() {
        configurePokemonImage()
        configurePokemonIdLabel()
        configurePokemonNameLabel()
        configurePokemonTitleLabel()
        configureAbilities()
        configureHeight()
        configureWeight()
    }
    
    private func configurePokemonImage() {
        view.addSubview(pokemonImage)
        pokemonImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(pokemonImage.snp.width)
        }
    }
    
    private func configurePokemonIdLabel() {
        view.addSubview(pokemonIdLabel)
        pokemonIdLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(pokemonImage.snp.bottom).inset(4)
        }
    }
    
    private func configurePokemonNameLabel() {
        view.addSubview(pokemonNameLabel)
        pokemonNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(pokemonIdLabel.snp.bottom)
        }
    }
    
    private func configurePokemonTitleLabel() {
        view.addSubview(pokemonTitleLabel)
        pokemonTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(pokemonNameLabel.snp.bottom)
        }
    }
    
    private func configureAbilities() {
        view.addSubview(abilitiesLabel)
        abilitiesLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(pokemonTitleLabel.snp.bottom)
        }
    }
    
    private func configureHeight() {
        view.addSubview(heightLabel)
        heightLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(abilitiesLabel.snp.bottom)
        }
    }
    
    private func configureWeight() {
        view.addSubview(weightLabel)
        weightLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(heightLabel.snp.bottom)
        }
    }
}
