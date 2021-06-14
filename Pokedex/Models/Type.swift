//
//  Type.swift
//  Pokedex
//
//  Created by Matheus Torres on 11/06/21.
//

import UIKit

enum Type: String, Codable {
    case normal, fighting, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electric, psychic, ice, dragon, dark, fairy, unknown, shadow
    
    var backgroundColor: UIColor {
        switch self {
            case .normal: return .normal
            case .fighting: return .fighting
            case .flying: return .flying
            case .poison: return .poison
            case .ground: return .ground
            case .rock: return .rock
            case .bug: return .bug
            case .ghost: return .ghost
            case .steel: return .steel
            case .fire: return .fire
            case .water: return .water
            case .grass: return .grass
            case .electric: return .electric
            case .psychic: return .psychic
            case .ice: return .ice
            case .dragon: return .dragon
            case .dark: return .dark
            case .fairy: return .fairy
            case .unknown: return .unknown
            case .shadow: return .shadow
        }
    }
}

