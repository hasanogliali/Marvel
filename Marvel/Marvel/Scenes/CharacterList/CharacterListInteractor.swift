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
    var characters: CharacterResponse? { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic?
    var characters: CharacterResponse?
    
    init(worker: CharacterListWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacters() {
        print(characters)
    }
}
