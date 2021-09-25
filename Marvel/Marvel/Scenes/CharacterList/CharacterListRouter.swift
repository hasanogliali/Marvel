//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import UIKit

protocol CharacterListRoutingLogic: AnyObject {
    func routeToCharacterDetail()
}

protocol CharacterListDataPassing: AnyObject {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: CharacterListRoutingLogic, CharacterListDataPassing {
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
    func routeToCharacterDetail() {
        let characterDetail = UIStoryboard(name: "CharacterDetail", bundle: .main)
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        characterDetail.router?.dataStore?.character = dataStore?.characters[dataStore?.selectedCharacterIndex ?? 0]
        characterDetail.router?.dataStore?.selectedCharacterIndex = dataStore?.selectedCharacterIndex
        characterDetail.router?.dataStore?.delegate = viewController
        self.viewController?.navigationController?.pushViewController(characterDetail, animated: true)
    }
}
