//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import Foundation
final class RMCharacterCollectionViewCellViewModel:Hashable,Equatable {

    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
    
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
        return "Status :\(characterStatus.rawValue)"
    }
    
    public var characterNameText : String{
        return characterName
    }
    
    public func fecthImage(completion: @escaping (Result<Data,Error>)->Void){
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url,completation: completion)
    }
}
