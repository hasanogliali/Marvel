//
//  SplashWorker.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import Foundation
import API

protocol SplashWorkingLogic: AnyObject {
    func getCharacters(
        request: CharacterResponse.Request,
        completion: @escaping ((Result<CharacterResponse, Error>) -> Void)
    )
}

final class SplashWorker: SplashWorkingLogic {
    func getCharacters(
        request: CharacterResponse.Request,
        completion: @escaping ((Result<CharacterResponse, Error>) -> Void)
    ) {
        API.Character.list(request).fetchResponse(CharacterResponse.self, completion: completion)
    }
}
