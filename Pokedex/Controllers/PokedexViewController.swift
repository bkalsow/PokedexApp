//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/13/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import UIKit

class PokedexViewController: UITableViewController {

    var pokemonArray = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Now lets populate our TableView
        let newUrl = Bundle.main.url(forResource: "pokemon_names", withExtension: "json")
        
        guard let j = newUrl
            else{
                print("data not found")
                return
        }
        
        guard let d = try? Data(contentsOf: j)
            else { print("failed")
                return
                
        }
        
        guard let rootJSON = try? JSONSerialization.jsonObject(with: d, options: [])
            else{ print("failedh")
                return
                
        }
        
        if let JSON = rootJSON as? [String: Any] {
            let pokemon = Pokemon()
            pokemon.id = (JSON["id"] as? IntegerLiteralType)!
            pokemon.name = (JSON["name"] as? String)!
            pokemonArray.append(pokemon)
            print("Pokemon Name" + pokemon.name)
            
            self.tableView.reloadData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
       
        let pokemon = pokemonArray[indexPath.row]
        
        print(pokemon.name)
        
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
}

