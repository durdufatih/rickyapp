//
//  RMService.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import Foundation
final class RMService{
    
    static let shared = RMService()
    private init(){
        
    }
    
    public func execute<T:Codable>(_ request:RmRequest ,expecting type:T.Type, completion:@escaping (Result<String,Error>)->Void){
        
    }
}
