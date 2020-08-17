//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/14/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import Foundation

struct PokemonManager {
    let resourceURL:URL
    
    
    init() {
        //URL to get data from
        let resourceString = "https://api.myjson.com/bins/18j0ns"
        
        guard let resourceURL = URL(string: resourceString) else {return}
        
        self.resourceURL = resourceURL
    }
    
    func getPokemon(completion: (Result<[Pokemon], Error>)) -> Void {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _/ _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailible))
    }
    
    do {
        let decoder = JSONDecoder()
    let pokemonResponse = try decoder.decode(pokemonResponse.self, from: jasonData
    let pokemonDetails = pokemonResponse.response.pokemon
    completion(.success(pokemonDetails))
    }catch {
    conpletion(.failure(.cannotProcessData))
    }
    }
    
    dataTask.resume()
    }
}
