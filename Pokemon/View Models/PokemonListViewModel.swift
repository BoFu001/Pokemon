//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by BoFu on 28/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

class PokemonListViewModel: BaseViewModel {
    
    private(set) var offset = 0
    let limit = 20
    
    private(set) var isComplete = false
    private var results = [Result]()
    
    var url: URL? {
        return URL(string: String(format: Constants.POKEMON_LIST_URL, "\(offset)", "\(limit)"))
    }
}


extension PokemonListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.results.count
    }
    
    func resultAtIndex(_ index: Int) -> Result {
        return self.results[index]
    }
    
    func addResults(_ results: [Result]) {
        self.results += results
        self.offset += results.count
        if results.count < self.limit {
            self.isComplete = true
        }
        print("Added other \(results.count) new items and the total num in list is \(self.results.count)")
    }
    
    func pokemonDetailUrlAtIndex(_ index: Int) -> String {
        let pokemonDetailUrl = self.results[index].url
        return pokemonDetailUrl
    }
    
    func fetchData(){

        guard let url = self.url else { return }

        if !self.isLoading {
            self.isLoading = true

            Networking().getData(url: url) { (pokemonListModel: PokemonListModel?) in

                DispatchQueue.main.async {
                    if let pokemonListModel = pokemonListModel {
                        self.addResults(pokemonListModel.results)
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
