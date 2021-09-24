//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import UIKit

protocol CharacterListRoutingLogic: AnyObject {
    func routeToCharacterDetail(index: Int)
}

protocol CharacterListDataPassing: AnyObject {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: CharacterListRoutingLogic, CharacterListDataPassing {
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
    func routeToCharacterDetail(index: Int) {
        let characterDetail = UIStoryboard(name: "CharacterDetail", bundle: .main)
            .instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        characterDetail.router?.dataStore?.character = dataStore?.characters[index]
        self.viewController?.navigationController?.pushViewController(characterDetail, animated: true)
    }
}
