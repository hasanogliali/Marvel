//
//  SplashRouter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import UIKit

protocol SplashRoutingLogic: AnyObject {
    func routeToCharacterList()
}

protocol SplashDataPassing: AnyObject {
    var dataStore: SplashDataStore? { get }
}

final class SplashRouter: SplashRoutingLogic, SplashDataPassing {
    
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?
    
    func routeToCharacterList() {
        let characterList = UIStoryboard(name: "CharacterList", bundle: .main)
            .instantiateViewController(
                withIdentifier: "CharacterListViewController"
            ) as! CharacterListViewController
        let navContr = UINavigationController(rootViewController: characterList)
        navContr.modalPresentationStyle = .fullScreen
        characterList.router?.dataStore?.characters = dataStore?.characters
        self.viewController?.present(navContr, animated: true)
    }
}
