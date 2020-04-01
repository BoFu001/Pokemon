//
//  PokemonListModel.swift
//  Pokemon
//
//  Created by BoFu on 28/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

// MARK: - PokemonList
struct PokemonListModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}
