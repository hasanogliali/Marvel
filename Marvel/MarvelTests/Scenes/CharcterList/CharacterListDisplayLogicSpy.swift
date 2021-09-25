//
//  CharacterListDisplayLogicSpy.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
import XCTest

final class CharacterListDisplayLogicSpy: CharacterListDisplayLogic {
    func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel) {
        
    }
    
    func displayError(_ message: String) {
        
    }
    
    var characterSelectionCalled = false
    func displayCharacterSelection() {
        characterSelectionCalled = true
    }
}
