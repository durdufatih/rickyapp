//
//  RMEpisode.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import Foundation

struct RmEpisode:Codable {
    let id : Int
    let name : String
    let air_date : String
    let episode : String
    let charaters : [String]
    let url : String
    let created : String
    
}
