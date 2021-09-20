//
//  SplashInteractor.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import Foundation
import API

protocol SplashBusinessLogic: AnyObject {
    func fetchCharacters()
}

protocol SplashDataStore: AnyObject {
    var characters: CharacterResponse? { get set }
}

final class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    
    var presenter: SplashPresentationLogic?
    var worker: SplashWorkingLogic?
    var characters: CharacterResponse?
    
    init(worker: SplashWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacters() {
        worker?.getCharacters(request: .init(offset: 0), completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.characters = response
                self?.presenter?.presentCharacters()
            case let .failure(error):
                self?.presenter?.presentError(error.localizedDescription)
            }
        })
    }
}
