//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by BoFu on 29/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import UIKit

class PokemonDetailViewController: BaseViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    var pokemonDetailViewModel: PokemonDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    override func retry() {
        pokemonDetailViewModel?.fetchData()
    }
}


// MARK: - ViewModel
extension PokemonDetailViewController {
    
    private func setupViewModel() {
        
        pokemonDetailViewModel?.updateLoading = { isLoading in
            self.showSpinner(isLoading)
        }
        
        pokemonDetailViewModel?.dataLoaded = { isSuccuss in
            if isSuccuss {
                self.updateUI()
                self.hideNoConnctionScreen(true)
            } else {
                self.hideNoConnctionScreen(false)
            }
        }
        pokemonDetailViewModel?.fetchData()
    }
}



// MARK: - User interface
extension PokemonDetailViewController {
    
    private func updateUI() {
        
        if let url = pokemonDetailViewModel?.imageUrl {
            self.avatarImageView.setAvatar(url: url)
        }
            
        nameLabel.text = pokemonDetailViewModel?.name
        typeLabel.text = pokemonDetailViewModel?.type
        heightLabel.text = pokemonDetailViewModel?.height
        weightLabel.text = pokemonDetailViewModel?.weight
        statLabel.text = pokemonDetailViewModel?.stat
    }
    
    private func hideNoConnctionScreen(_ bool: Bool){
        if bool {
            self.noConnectionView?.alpha = 0
        } else {
            self.noConnectionView?.alpha = 1
        }
    }

    private func showSpinner(_ bool: Bool){
        if bool {
            spinner.isHidden = false
        } else {
            spinner.isHidden = true
        }
    }
}



