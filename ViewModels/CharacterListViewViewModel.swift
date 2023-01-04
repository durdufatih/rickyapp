//
//  CharacterListViewViewModel.swift
//  RickyAndMorty
//
//  Created by Mehmet Fatih Durdu on 30.12.2022.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate : AnyObject{
    func didLoadInitialCharacters()
    func didMoreInitailCharacters(with newIndexPath: [IndexPath])
    func didSelectCharacter(_ character : RMCharacter)
}

final class CharacterListViewModel : NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters:[RMCharacter] = []{
        didSet{
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
                
            }
        }
    }
    
    private var cellViewModels:[RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo : RMGetAllCharacterResponse.Info? = nil
    
    public func fetchCharacter(){
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharacterResponse.self)
        { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                let info = responseModel.info
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    public func fetchAdditionalCharacter(url:URL){
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = RmRequest(url:url) else {
            isLoadingMoreCharacters = false
            return
        }
        RMService.shared.execute(request, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount - 1
                let indexPathsToAdd : [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({ return IndexPath(row:$0, section: 0)})
                
                strongSelf.characters.append(contentsOf: moreResults)
                print(String(strongSelf.characters.count))
                DispatchQueue.main.async {
                    strongSelf.delegate?.didMoreInitailCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
        
    }
    public var shouldShowLoadMoreIndicator:Bool {
        return apiInfo?.next != nil
    }
}

extension CharacterListViewModel:UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMChracterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMChracterCollectionViewCell else {
                fatalError("Unsupported cell")
            }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView
                     else { fatalError("Unsupported")}
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    
}

extension CharacterListViewModel:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,!isLoadingMoreCharacters,!cellViewModels.isEmpty
                , let nextUrlString=apiInfo?.next,
                let url = URL(string: nextUrlString) else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScroolViewFixedHeight = scrollView.frame.size.height
            if offset >= (totalContentHeight-totalScroolViewFixedHeight-120){
                self?.fetchAdditionalCharacter(url: url)
            }
            t.invalidate()
        }
         
       
        
    }
}

