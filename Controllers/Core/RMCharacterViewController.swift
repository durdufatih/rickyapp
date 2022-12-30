//
//  RMCharacterViewController.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 29.12.2022.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        // Do any additional setup after loading the view.
        
        let request = RmRequest(
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive")]
        )
        
        print(request.url)
        
        RMService.shared.execute(request, expecting: Character.self) { result in
            
        }
    }


}
