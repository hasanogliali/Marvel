//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import API

protocol CharacterDetailBusinessLogic: AnyObject {
    func fetchCharacterDetail()
}

protocol CharacterDetailDataStore: AnyObject {
    var character: CharacterItem? { get set }
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorkingLogic?
    
    var character: CharacterItem?
    
    init(worker: CharacterDetailWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacterDetail() {
        presenter?.presentCharacterDetail(response: .init(character: character))
    }
}
