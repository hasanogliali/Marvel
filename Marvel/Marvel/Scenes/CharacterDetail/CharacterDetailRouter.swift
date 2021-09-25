//
//  CharacterDetailRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import Foundation

protocol CharacterDetailRoutingLogic: AnyObject {
    func popViewController()
}

protocol CharacterDetailDataPassing: AnyObject {
    var dataStore: CharacterDetailDataStore? { get }
}

final class CharacterDetailRouter: CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?
    
    func popViewController() {
        if let index = dataStore?.selectedCharacterIndex {
            dataStore?.delegate?.checkCharacterFavorite(with: index)
        }
        viewController?.navigationController?.popViewController(animated: true)
    }
}
