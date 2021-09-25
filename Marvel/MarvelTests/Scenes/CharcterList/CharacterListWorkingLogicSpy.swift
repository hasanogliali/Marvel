//
//  CharacterListWorkingLogicSpy.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
import XCTest
@testable import API

final class CharacterListWorkingLogicSpy: CharacterListWorkingLogic {
    func getCharacters(request: CharacterResponse.Request, completion: @escaping ((Result<CharacterResponse, Error>) -> Void)) {
        StubData.getDataFromLocal(fileName: "character", callback: completion)
    }
}
