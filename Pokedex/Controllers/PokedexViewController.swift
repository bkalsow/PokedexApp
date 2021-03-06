//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/13/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import UIKit
import CoreData

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var switchButton: UIButton!
    
    var pokemonArray = [Pokemon]()
    var DisplayedPokemonArray = [Pokemon]()
    
    func initializeContent() {
        //file name to read
        let fileName = "pokemon_names"
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return }
        guard let pokemons = json as? [Any] else {return }
        for pokemon in pokemons {
            guard let pokemonDict = pokemon as? [String: Any] else {return}
            guard let id = pokemonDict["id"] as? String else {return}
            guard let name = pokemonDict["name"] as? String else {return}
            self.pokemonArray.append(Pokemon(id:Int(id)!, name:name))
        }
        
        self.DisplayedPokemonArray = self.pokemonArray
        
    }
    
    @IBAction func switchView(_ sender: UIButton) {
        pokemonCollectionView.isHidden = !pokemonCollectionView.isHidden
        pokemonTableView.isHidden = !pokemonTableView.isHidden
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeContent()
        pokemonCollectionView.isHidden = true
        pokemonTableView.isHidden = false
    }
}

//MARK: CollectionView Data Source Methods
extension PokedexViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DisplayedPokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionCell", for: indexPath) as! PokemonCollectionViewCell
        
        cell.name.text = DisplayedPokemonArray[indexPath.item].name
        cell.id.text = "#" + String(format: "%03d", DisplayedPokemonArray[indexPath.item].id)
        let url = self.DisplayedPokemonArray[indexPath.item].image
        cell.image.load(url: URL(string: url)!)
        
        return cell
    }
    
}

//MARK: Tableview Data Source Methods
extension PokedexViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DisplayedPokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        cell.name.text = DisplayedPokemonArray[indexPath.row].name
        cell.id.text = "#" + String(format: "%03d", DisplayedPokemonArray[indexPath.row].id)
        let url = self.DisplayedPokemonArray[indexPath.row].image
        cell.pokemonImage.load(url: URL(string: url)!)
        
        return cell
    }
    
}

//MARK: Source Bar Delegate Methods
extension PokedexViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.DisplayedPokemonArray = pokemonArray.filter { (pokemon) -> Bool in
            pokemon.name.lowercased().contains(searchBar.text!.lowercased())
        }
        pokemonTableView.reloadData()
        pokemonCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.DisplayedPokemonArray = self.pokemonArray
            pokemonTableView.reloadData()
            pokemonCollectionView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

//MARK: Image View Methods
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
