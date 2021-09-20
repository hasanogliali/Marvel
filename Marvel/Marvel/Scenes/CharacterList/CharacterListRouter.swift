//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation

protocol CharacterListRoutingLogic: AnyObject {
    
}

protocol CharacterListDataPassing: AnyObject {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: CharacterListRoutingLogic, CharacterListDataPassing {
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
}
