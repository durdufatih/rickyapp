//
//  RMRequest.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import Foundation

final class RmRequest{
    
    private struct Constant{
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endpoint : RMEndpoint
    
    public let httpMethod = "GET"
    
    let pathComponents : [String]
    
    let queryParameters: [URLQueryItem]
    
    private var urlString:String{
        var string = Constant.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty{
            pathComponents.forEach ({ string += "/\($0)"
            })
        }
        if !queryParameters.isEmpty{
            string += "?"
            let argumentedString = queryParameters.compactMap ({
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"}).joined(separator:"&")
            
            string += argumentedString
        }
        
        
        
        return string
    }
    public var url:URL?{
        return URL(string: urlString)
    }
    init(endpoint: RMEndpoint, pathComponents: [String]=[], queryParameters: [URLQueryItem]=[]) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
