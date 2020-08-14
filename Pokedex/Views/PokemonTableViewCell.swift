//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Brandan Kalsow on 8/14/20.
//  Copyright © 2020 Virgin Pulse. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
