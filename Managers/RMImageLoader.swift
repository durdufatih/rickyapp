//
//  ImageLoader.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 5.01.2023.
//

import Foundation

final class RMImageLoader{
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString,NSData>()
    
    private init(){}
    
    public func downloadImage(_ url: URL, completation:@escaping (Result<Data,Error>)->Void){
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key){
            print("Reading from cache!!!")
            completation(.success(data as Data))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data ,error == nil else {
                completation(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            
            self?.imageDataCache.setObject(value, forKey: key)
            completation(.success(data))
        }
        task.resume()
    }
}
