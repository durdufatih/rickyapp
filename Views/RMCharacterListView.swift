//
//  CharacterListView.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(
        _ characterListView: RMCharacterListView,
        didSelectCharacter character: RMCharacter
    )
}
/// View that handles showing list of chracters
class RMCharacterListView: UIView {

    public weak var delegate: RMCharacterListViewDelegate?
    
    private let viewModel = CharacterListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinnerItem = UIActivityIndicatorView(style: .large)
        spinnerItem.hidesWhenStopped = true
        spinnerItem.translatesAutoresizingMaskIntoConstraints = false
        return spinnerItem
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout:layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMChracterCollectionViewCell.self, forCellWithReuseIdentifier: RMChracterCollectionViewCell.cellIdentifier)
        
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView,spinner)
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacter()
        setUpCollectionView()
        //spinner.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported ")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
     
    }
}

extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didMoreInitailCharacters(with newIndexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        self.delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
   
}
