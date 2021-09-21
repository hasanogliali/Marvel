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
    func fetchSearch(request: CharacterList.FetchSearch.Request)
}

protocol CharacterListDataStore: AnyObject {
    var characters: [CharacterItem] { get set }
    var filteredCharacters: [CharacterItem] { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic?
    var characters: [CharacterItem] = []
    var filteredCharacters: [CharacterItem] = []
    
    init(worker: CharacterListWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacters() {
        self.presenter?.presentCharacters(response: .init(characters: characters))
    }
    
    func fetchSearch(request: CharacterList.FetchSearch.Request) {
        if request.searchText == "" {
            presenter?.presentCharacters(response: .init(characters: characters))
        } else {
            filteredCharacters = getFilteredList(filterText: request.searchText) ?? []
            presenter?.presentCharacters(response: .init(characters: filteredCharacters))
        }
    }
    
    private func getFilteredList(filterText: String) -> [CharacterItem]? {
        characters.filter { character -> Bool in
            let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
            let matchedName = character.name?.range(of: filterText, options: options) != nil
            return matchedName
        }
    }
}
