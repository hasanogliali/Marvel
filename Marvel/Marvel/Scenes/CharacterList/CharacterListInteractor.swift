//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation
import API

protocol CharacterListBusinessLogic: AnyObject {
    func fetchCharacters()
}

protocol CharacterListDataStore: AnyObject {
    var characters: [CharacterItem] { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic?
    var characters: [CharacterItem] = []
    
    init(worker: CharacterListWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacters() {
        self.presenter?.presentCharacters(response: .init(characters: characters))
    }
}
