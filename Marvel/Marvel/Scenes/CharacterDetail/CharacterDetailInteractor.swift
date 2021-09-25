//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import API

protocol CharacterDetailBusinessLogic: AnyObject {
    func fetchCharacterDetail()
    func handleFavorite()
    func saveCharacter()
}

protocol CharacterDetailDataStore: AnyObject {
    var character: CharacterItem? { get set }
    var selectedCharacterIndex: Int? { get set }
    var delegate: CharacterDetailFavoriteDelegate? { get set }
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorkingLogic?
    
    var character: CharacterItem?
    var selectedCharacterIndex: Int?
    weak var delegate: CharacterDetailFavoriteDelegate?
    
    init(worker: CharacterDetailWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCharacterDetail() {
        presenter?.presentCharacterDetail(response: .init(character: character))
    }
    
    func handleFavorite() {
        UserDefaultsHelper.Favorites.handleFavorite(character?.id ?? 0)
        presenter?.presentFavorite()
    }
    
    func saveCharacter() {
        if UserDefaultsHelper.Character.isCharacterSaved("\(character?.id ?? 0)") {
            presenter?.presentSaveCharacter(response: .init(existBefore: true, saved: true))
        } else {
            UserDefaultsHelper.Character.save(
                character, with: "\(character?.id ?? 0)"
            )
            presenter?.presentSaveCharacter(
                response: .init(
                    existBefore: false,
                    saved: UserDefaultsHelper.Character.isCharacterSaved("\(character?.id ?? 0)")
                )
            )
        }
    }
}
