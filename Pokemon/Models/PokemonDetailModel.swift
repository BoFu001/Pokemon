//
//  PokemonDetailModel.swift
//  Pokemon
//
//  Created by BoFu on 29/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

// MARK: - PokemonDetailModel
struct PokemonDetailModel: Codable {
    
    let name: String
    var formattedType: String {
        return types.compactMap({ $0.type.name.capitalized }).joined(separator: ", ")
    }
    let height: Int
    let weight: Int
    var formattedStat: String {
        return stats.compactMap({ $0.stat.name.capitalized }).joined(separator: ", ")
    }
    var imageUrl: String? {
        return sprites.frontImage
    }
    
    let types: [TypeElement]
    let stats: [Stat]
    let species: Species
    let sprites: Sprites
}



// MARK: - Species
struct Species: Codable {
    let name: String
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontImage: String?
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let stat: Species
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let type: Species
}
