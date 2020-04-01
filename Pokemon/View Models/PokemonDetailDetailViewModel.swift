//
//  PokemonDetailDetailViewModel.swift
//  Pokemon
//
//  Created by BoFu on 29/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

class PokemonDetailViewModel: BaseViewModel {
    
    private var pokemonDetailModel: PokemonDetailModel?
    private var url: String
    
    var name: String {
        return self.pokemonDetailModel?.name.capitalized ?? ""
    }
    
    var type: String {
        return self.pokemonDetailModel?.formattedType ?? ""
    }
    
    var height: String {
        return self.pokemonDetailModel?.height.toString ?? ""
    }
    
    var weight: String {
        return self.pokemonDetailModel?.weight.toString ?? ""
    }
    
    var stat: String {
        return self.pokemonDetailModel?.formattedStat ?? ""
    }
    
    var imageUrl: String? {
           return self.pokemonDetailModel?.imageUrl
    }
    
    init(url: String) {
        self.url = url
    }
    
    func fetchData(){

        guard let url = URL(string: self.url) else { return }

        if !self.isLoading {
            self.isLoading = true

            Networking().getData(url: url) { (pokemonDetailModel: PokemonDetailModel?) in

                DispatchQueue.main.async {
                    if let pokemonDetailModel = pokemonDetailModel {
                        self.pokemonDetailModel = pokemonDetailModel
                        self.dataLoaded?(true)
                    } else {
                        self.dataLoaded?(false)
                    }
                    self.isLoading = false
                }
            }
        }
    }
}


