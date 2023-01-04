//
//  RMCollectionReusableView.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 3.01.2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinnerItem = UIActivityIndicatorView(style: .large)
        spinnerItem.hidesWhenStopped = true
        spinnerItem.translatesAutoresizingMaskIntoConstraints = false
        return spinnerItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimating(){
        spinner.startAnimating()
    }
        
}
