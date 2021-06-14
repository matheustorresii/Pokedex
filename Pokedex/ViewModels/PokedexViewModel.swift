//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Matheus Torres on 11/06/21.
//

import Foundation
import RxSwift
import RxCocoa

class PokedexViewModel {
    // MARK: - Properties
    public let pokemons: BehaviorSubject<[Pokemon]> = BehaviorSubject(value: [])
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let errorMessage: PublishSubject<String> = PublishSubject()
    public let offset: BehaviorSubject<Int> = BehaviorSubject(value: 0)

    private let service = PokedexService()
    
    // MARK: - Helpers
    func getPokedex() {
        guard let currentOffset = try? offset.value(), let pokemons = try? pokemons.value() else {
            clearPokedex(error: .unknown)
            return
        }
        
        loading.onNext(true)
        offset.onNext(currentOffset + 20)
        self.service.fetchPokedex(offset: String(currentOffset)) { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            switch result {
                case .success(let pokemonArray):
                    self.hideErrorMessage(pokemons: pokemons + pokemonArray)
                case .failure(let error):
                    self.clearPokedex(error: error)
            }
        }
    }
    
    func getPokemon(with id: String) {
        if id.isEmpty {
            clearPokedex()
            getPokedex()
            return
        }
        
        loading.onNext(true)
        self.service.fetchPokemon(id: id.lowercased()) { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            switch result {
                case .success(let pokemon):
                    self.hideErrorMessage(pokemons: [pokemon])
                case .failure(let error):
                    self.clearPokedex(error: error)
            }
        }
    }
    
    func loadMorePokemonIfNeeded(at indexPath: IndexPath) {
        if let currentOffset = try? offset.value() {
            if indexPath.item == (currentOffset - 1) {
                getPokedex()
            }
        }
    }
    
    private func hideErrorMessage(pokemons: [Pokemon]) {
        self.pokemons.onNext(pokemons)
        self.errorMessage.onNext("")
    }
    
    private func clearPokedex(error: APIService.RequestError? = nil) {
        self.pokemons.onNext([])
        offset.onNext(0)
        if let error = error {
            self.errorMessage.onNext(APIService.getErrorMessage(for: error))
        }
    }
}
