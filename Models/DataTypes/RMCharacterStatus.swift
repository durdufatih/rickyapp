//
//  RMCharaterStatus.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import Foundation


enum RMCharacterStatus:String,Codable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text:String{
        switch self {
        case .alive,.dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
