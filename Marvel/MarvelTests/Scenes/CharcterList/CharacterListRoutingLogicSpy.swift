//
//  CharacterListRoutingLogicSpy.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
import XCTest

final class CharacterListRoutingLogicSpy: CharacterListRoutingLogic, CharacterListDataPassing {
    var dataStore: CharacterListDataStore?
    
    var routeToCharacterDetailCalled = false
    func routeToCharacterDetail() {
        routeToCharacterDetailCalled = true
    }
}
