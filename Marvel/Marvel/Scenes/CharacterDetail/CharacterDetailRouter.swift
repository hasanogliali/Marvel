//
//  CharacterDetailRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import Foundation

protocol CharacterDetailRoutingLogic: AnyObject {
    
}

protocol CharacterDetailDataPassing: AnyObject {
    var dataStore: CharacterDetailDataStore? { get }
}

final class CharacterDetailRouter: CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?
    
}
