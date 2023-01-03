//
//  RMGetCharacterResponse.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import Foundation

class RMGetAllCharacterResponse : Codable{
    
    struct Info : Codable{
        let count: Int
        let pages: Int
        let next: String?
        let prev : String?
    }
    
    
    let info : Info
    let results : [RMCharacter]
}

