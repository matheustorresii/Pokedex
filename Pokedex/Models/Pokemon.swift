//
//  Pokemon.swift
//  Pokedex
//
//  Created by Matheus Torres on 11/06/21.
//

import Foundation

public struct Pokemon: Codable {
    let id: Int
    let name: String
    let genera: [Genera]
    let types: [Type]
    let abilities: [String]
    let height: Int
    let weight: Int
    let baseExperience: Int
    let stats: [Stats]
    
    enum CodingKeys: String, CodingKey {
        case id, name, genera, types, abilities, height, weight, baseExperience = "base_experience", stats
    }
}

public struct Genera: Codable {
    let genus: String
    let language: String
}

public struct Stats: Codable {
    let baseStat: Int
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
    }
}
