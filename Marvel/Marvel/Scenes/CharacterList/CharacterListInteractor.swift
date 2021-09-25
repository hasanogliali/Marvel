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
    func fetchNewCharacters()
    func characterSelected(request: CharacterList.FetchCharacterSelection.Request)
}

protocol CharacterListDataStore: AnyObject {
    var characters: [CharacterItem] { get set }
    var filteredCharacters: [CharacterItem] { get set }
    var selectedCharacterIndex: Int { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic?
    var characters: [CharacterItem] = []
    var filteredCharacters: [CharacterItem] = []
    var isFetchingMore = false
    var isSearchActive = false
    var nextCharactersStartIndex = 20
    var selectedCharacterIndex: Int = 0
    
    init(worker: CharacterListWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacters() {
        self.presenter?.presentCharacters(response: .init(characters: characters, isSearchActive: false))
    }
    
    func fetchNewCharacters() {
        if !isFetchingMore, !isSearchActive {
            getNewPage()
        }
    }
    
    private func getNewPage() {
        isFetchingMore = true
        worker?.getCharacters(request: .init(offset: "\(nextCharactersStartIndex)"), completion: { [weak self] result in
            self?.isFetchingMore = false
            switch result {
            case let .success(response):
                self?.nextCharactersStartIndex += 20
                self?.characters.append(contentsOf: response.data?.results ?? [])
                self?.presenter?.presentCharacters(
                    response: .init(characters: self?.characters ?? [], isSearchActive: false)
                )
            case let .failure(error):
                self?.presenter?.presentError(error.localizedDescription)
            }
        })
    }
    
    func fetchSearch(request: CharacterList.FetchSearch.Request) {
        if request.searchText == "" {
            isSearchActive = false
            presenter?.presentCharacters(response: .init(characters: characters, isSearchActive: isSearchActive))
        } else {
            isSearchActive = true
            filteredCharacters = getFilteredList(filterText: request.searchText) ?? []
            presenter?.presentCharacters(response: .init(characters: filteredCharacters, isSearchActive: isSearchActive))
        }
    }
    
    func characterSelected(request: CharacterList.FetchCharacterSelection.Request) {
        self.selectedCharacterIndex = request.index
        presenter?.presentCharacterSelection()
    }
    
    private func getFilteredList(filterText: String) -> [CharacterItem]? {
        characters.filter { character -> Bool in
            let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
            let matchedName = character.name?.range(of: filterText, options: options) != nil
            return matchedName
        }
    }
}
