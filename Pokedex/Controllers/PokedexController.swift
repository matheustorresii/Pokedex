//
//  PokedexController.swift
//  Pokedex
//
//  Created by Matheus Torres on 10/06/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PokedexController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = PokedexViewModel()
    private let pokemons = BehaviorSubject<[Pokemon]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Properties
    private lazy var searchBox = SearchBoxView()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .pokedexLightGray
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: "PokedexCell")
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = .pokedexRed
        aiv.style = .large
        return aiv
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pokedexOpaqueBlack
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBindings()
        viewModel.getPokedex()
    }
    
    // MARK: - Bindings
    
    private func configureBindings() {
        configureViewModelBindings()
        configureCollectionViewBindings()
        
        searchBox.rx.didSearch.subscribe(onNext: { [weak self] value in
            self?.viewModel.getPokemon(with: value)
        }).disposed(by: disposeBag)
    }
    
    private func configureViewModelBindings() {
        viewModel.loading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.pokemons.bind(to: pokemons).disposed(by: disposeBag)
        
        viewModel.errorMessage.subscribe(onNext: { [weak self] errorMessage in
            self?.errorMessageLabel.text = errorMessage
        }).disposed(by: disposeBag)
    }
    
    private func configureCollectionViewBindings() {
        pokemons.bind(to: collectionView.rx.items(cellIdentifier: "PokedexCell", cellType: PokedexCell.self)) { row, pokemon, cell in
            cell.setupCell(for: pokemon)
        }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell.subscribe(onNext: { [weak self] _, indexPath in
            self?.viewModel.loadMorePokemonIfNeeded(at: indexPath)
        }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Pokemon.self).subscribe(onNext: { [weak self] model in
            self?.navigationController?.pushViewController(PokemonController(pokemon: model), animated: false)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.title = "Pokédex"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        configureViews()
    }
    
    private func configureViews() {
        configureSearchBox()
        configureCollectionView()
        configureActivityIndicator()
        configureErrorMessageLabel()
    }
    
    private func configureSearchBox() {
        view.addSubview(searchBox)
        searchBox.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(searchBox.snp.bottom)
        }
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func configureErrorMessageLabel() {
        view.addSubview(errorMessageLabel)
        errorMessageLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Flow Layout
extension PokedexController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 144.0
        let itemsPerRow: CGFloat = 2
        let width: CGFloat = (collectionView.frame.width - (PokedexCollectionViewInsets.horizontalInset * (itemsPerRow + 1)))/itemsPerRow
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return PokedexCollectionViewInsets.horizontalInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PokedexCollectionViewInsets.verticalInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: PokedexCollectionViewInsets.verticalInset,
                            left: PokedexCollectionViewInsets.horizontalInset,
                            bottom: PokedexCollectionViewInsets.verticalInset,
                            right: PokedexCollectionViewInsets.horizontalInset)
    }
}

fileprivate struct PokedexCollectionViewInsets {
    static let verticalInset: CGFloat = 16.0
    static let horizontalInset: CGFloat = 8.0
}
