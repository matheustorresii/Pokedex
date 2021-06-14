//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Matheus Torres on 10/06/21.
//

import UIKit
import SnapKit
import Kingfisher

class PokedexCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var pokemonIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var typeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    public func setupCell(for pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        let formattedID = String(format: "%03d", pokemon.id)
        pokemonIdLabel.text = "#\(formattedID)"
        let imageUrl = "https://raw.githubusercontent.com/msikma/pokesprite/master/pokemon-gen8/regular/\(pokemon.name.lowercased()).png"
        pokemonImage.kf.setImage(with:URL(string: imageUrl)!,
                                 placeholder: UIImage(named: "pokeIcon")!)
        configureTypeStackFor(types: pokemon.types)
    }
    
    private func configureTypeStackFor(types: [Type]) {
        clearTypeStack()
        for type in types {
            let label = UILabel()
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 4
            label.textColor = .pokedexOpaqueBlack
            label.backgroundColor = type.backgroundColor
            label.font = .systemFont(ofSize: 12, weight: .bold)
            label.text = " \(type.rawValue.uppercased()) "
            label.snp.makeConstraints { $0.height.equalTo(20) }
            typeStack.addArrangedSubview(label)
        }
    }
    
    private func clearTypeStack() {
        typeStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureViews() {
        configureCellBackground()
        configurePokemonImage()
        configurePokemonID()
        configurePokemonName()
        configureTypeStack()
    }
    
    private func configureCellBackground() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottomMargin.equalTo(contentView.snp.bottom).inset(4)
            make.topMargin.equalTo(contentView.snp.top).offset(32)
        }
    }
    
    private func configurePokemonImage() {
        contentView.addSubview(pokemonImage)
        pokemonImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(cellBackgroundView.snp.top)
        }
    }
    
    private func configurePokemonID() {
        contentView.addSubview(pokemonIdLabel)
        pokemonIdLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configurePokemonName() {
        contentView.addSubview(pokemonNameLabel)
        pokemonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonIdLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureTypeStack() {
        contentView.addSubview(typeStack)
        typeStack.snp.makeConstraints { make in
            make.top.equalTo(pokemonNameLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
