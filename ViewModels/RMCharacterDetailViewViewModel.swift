//
//  RMCharacterDetailViewViewModel.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 2.01.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel{
    
    private let character: RMCharacter
    
    init(character:RMCharacter){
        self.character = character
    }
    
    public var title : String {
        character.name.uppercased()
    }
    
    
}
