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
    
    convenience init?(url:URL){
        let string = url.absoluteString
        if !string.contains(Constant.baseUrl){
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constant.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty{
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        }else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty , components.count>=2{
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else{
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint,queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
}

extension RmRequest {
    static let listCharactersRequest = RmRequest(endpoint: .character)
}
