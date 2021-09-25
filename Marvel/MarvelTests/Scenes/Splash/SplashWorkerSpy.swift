//
//  SplashWorkerSpy.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
@testable import API
import XCTest

final class SplashWorkerSpy: SplashWorkingLogic {
    func getCharacters(request: CharacterResponse.Request, completion: @escaping ((Result<CharacterResponse, Error>) -> Void)) {
        StubData.getDataFromLocal(fileName: "character", callback: completion)
    }
}
