//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation
import API

protocol CharacterListWorkingLogic: AnyObject {
    func getCharacters(
        request: CharacterResponse.Request,
        completion: @escaping ((Result<CharacterResponse, Error>) -> Void)
    )
}

final class CharacterListWorker: CharacterListWorkingLogic {
    func getCharacters(
        request: CharacterResponse.Request,
        completion: @escaping ((Result<CharacterResponse, Error>) -> Void)
    ) {
        API.Character.list(request).fetchResponse(CharacterResponse.self, completion: completion)
    }
}
