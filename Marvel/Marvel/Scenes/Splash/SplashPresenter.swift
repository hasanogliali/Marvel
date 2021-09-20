//
//  SplashPresenter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import Foundation

protocol SplashPresentationLogic: AnyObject {
    func presentCharacters()
    func presentError(_ message: String)
}

final class SplashPresenter: SplashPresentationLogic {
    
    weak var viewController: SplashDisplayLogic?
    
    func presentCharacters() {
        viewController?.displayCharacters()
    }
    
    func presentError(_ message: String) {
        viewController?.displayError(message)
    }
}
