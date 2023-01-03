//
//  RmCharacterDetailViewController.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 2.01.2023.
//

import UIKit

/// this conttroller show info about single character
class RmCharacterDetailViewController: UIViewController {
    
    private let viewModel :RMCharacterDetailViewViewModel

    init(viewModel:RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    

}
