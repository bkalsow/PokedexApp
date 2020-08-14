//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/14/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import Foundation

struct Pokemon {
    
    var name: String
    var id: Int
    var image: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.image = "http://img.pokemondb.net/artwork/\(self.name.lowercased().replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "♀", with: "-f").replacingOccurrences(of: "♂", with: "-m")).jpg"
    }
}
