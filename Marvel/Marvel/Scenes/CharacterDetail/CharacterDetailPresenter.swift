//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import Foundation

protocol CharacterDetailPresentationLogic: AnyObject {
    func presentCharacterDetail(response: CharacterDetail.FetchDetail.Response)
}

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
    func presentCharacterDetail(response: CharacterDetail.FetchDetail.Response) {
        viewController?.displayCharacterDetail(viewModel: .init(character: response.character))
    }
}
