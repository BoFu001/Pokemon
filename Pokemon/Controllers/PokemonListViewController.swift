//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by BoFu on 27/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import UIKit

class PokemonListViewController: BaseViewController {
    
    private var pokemonListViewModel = PokemonListViewModel()
    @IBOutlet weak var pokemonListTable: UITableView!
    
    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailViewController" {
            
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else {
                fatalError("PokemonDetailViewController not found")
            }
            guard let indexPath = pokemonListTable.indexPathForSelectedRow else {
                fatalError("pokemonListTable.indexPathForSelectedRow not found")
            }
            
            let pokemonDetailUrl = pokemonListViewModel.pokemonDetailUrlAtIndex(indexPath.row)
            let pokemonDetailViewModel = PokemonDetailViewModel(url: pokemonDetailUrl)
            pokemonDetailVC.pokemonDetailViewModel = pokemonDetailViewModel
            
        }
        
    }
    
    override func retry() {
        pokemonListViewModel.fetchData()
    }
    
}


// MARK: - ViewModel
extension PokemonListViewController {
    
    private func setupViewModel() {
        
        pokemonListViewModel.updateLoading = { isLoading in
            self.showSpinner(isLoading)
        }
        
        pokemonListViewModel.dataLoaded = { isSuccuss in
            if isSuccuss {
                self.pokemonListTable.reloadData()
                self.hideNoConnctionScreen(true)
                if self.pokemonListViewModel.isComplete {
                    self.dataCompletionAnim()
                }
            } else {
                self.hideNoConnctionScreen(false)
            }
        }
        pokemonListViewModel.fetchData()
    }
}

// MARK: - User interface
extension PokemonListViewController {
    
    private func setupUI() {
        hintView.layer.cornerRadius = 5
    }
    
    private func hideNoConnctionScreen(_ bool: Bool){
        if bool {
            noConnectionView?.alpha = 0
        } else {
            if pokemonListViewModel.offset == 0 {
                noConnectionView?.alpha = 1
            } else {
                noConnectionAnim()
            }
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


// MARK: - UITableView
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = pokemonListViewModel.resultAtIndex(indexPath.row).name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isComplete = pokemonListViewModel.isComplete
        if indexPath.row + 1 == pokemonListViewModel.offset && !isComplete {
            print("Touched the bottom while the list is not completed yet, then fetch data.")
            pokemonListViewModel.fetchData()
        }
    }
}


// MARK: - Hint Animation
extension PokemonListViewController {
    
    func dataCompletionAnim() {
        self.hintLabel.text = "All \(self.pokemonListViewModel.offset) Pokémons are loaded."
        self.hintAnimation()
    }
    
    func noConnectionAnim() {
        self.hintLabel.text = "Check your connection and try later."
        self.hintAnimation()
    }
    
    func hintAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
            self.hintView.alpha = 0.8
        }) { (finished) in
            UIView.animate(withDuration: 0.5, delay: 4, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                self.hintView.alpha = 0
            }, completion: nil)
        }
    }
}
