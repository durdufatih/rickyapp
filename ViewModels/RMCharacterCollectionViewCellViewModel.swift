//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import Foundation
final class RMCharacterCollectionViewCellViewModel {
    
    private let characterName : String
    private let characterStatus : RMCharacterStatus
    private let characterImageUrl : URL?
    init(
        characterName : String,
        characterStatus : RMCharacterStatus,
        characterImageUrl : URL?
    ){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText : String{
        return characterStatus.rawValue
    }
    
    public var characterNameText : String{
        return characterName
    }
    
    public func fecthImage(completion: @escaping (Result<Data,Error>)->Void){
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request){ data, _ ,error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
