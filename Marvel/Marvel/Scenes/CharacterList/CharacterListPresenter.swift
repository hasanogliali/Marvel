//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation

protocol CharacterListPresentationLogic: AnyObject {
    func presentCharacters(response: CharacterList.FetchCharacters.Response)
    func presentError(_ message: String)
    func presentCharacterSelection()
}

final class CharacterListPresenter: CharacterListPresentationLogic {
    
    weak var viewController: CharacterListDisplayLogic?
    
    func presentCharacters(response: CharacterList.FetchCharacters.Response) {
        var characterList = [CharacterList.FetchCharacters.ViewModel.CharacterCellModel]()
        response.characters.forEach {
            characterList.append(
                .init(
                    image: "\($0.thumbnail?.path ?? "").\($0.thumbnail?.thumbnailExtension ?? "")",
                    name: $0.name ?? "",
                    seriesCount: "Played in \($0.series?.items?.count ?? 0) series",
                    id: $0.id ?? 0
                )
            )
        }
        viewController?.displayCharacters(
            viewModel: .init(characters: characterList, isSearchActive: response.isSearchActive)
        )
    }
    
    func presentError(_ message: String) {
        viewController?.displayError(message)
    }
    
    func presentCharacterSelection() {
        viewController?.displayCharacterSelection()
    }
}
