//
//  PokedexService.swift
//  Pokedex
//
//  Created by Matheus Torres on 11/06/21.
//

import Foundation
import Alamofire

protocol PokedexNetworkable {
    func fetchPokedex(offset: String, completion: @escaping (Swift.Result<[Pokemon], APIService.RequestError>) -> Void)
    func fetchPokemon(id: String, completion: @escaping (Swift.Result<Pokemon, APIService.RequestError>) -> Void)
}

class PokedexService: PokedexNetworkable {
    // MARK: - Properties
    enum PokedexEndpoints: APIEndpoint {
        case catchAll(String)
        case pokemon(String)
        
        private var baseUrl: String { "https://pokeapi-torres.herokuapp.com" }
        
        var url: String {
            switch self {
                case .catchAll(let offset): return "\(baseUrl)/catchAll?limit=20&offset=\(offset)"
                case .pokemon(let id): return "\(baseUrl)/\(id)"
            }
        }
    }
    
    // MARK: - Helpers
    func fetchPokedex(offset: String, completion: @escaping (Result<[Pokemon], APIService.RequestError>) -> Void) {
        APIService.request(PokedexEndpoints.catchAll(offset), completion: completion)
    }
    
    func fetchPokemon(id: String, completion: @escaping (Result<Pokemon, APIService.RequestError>) -> Void) {
        APIService.request(PokedexEndpoints.pokemon(id), completion: completion)
    }
}
