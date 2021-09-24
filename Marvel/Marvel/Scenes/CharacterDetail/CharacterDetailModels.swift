//
//  CharacterDetailModels.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import API

// swiftlint:disable nesting
enum CharacterDetail {
    
    enum FetchDetail {
        
        struct Request {
            
        }
        
        struct Response {
            let character: CharacterItem?
        }
        
        struct ViewModel {
            let character: CharacterItem?
        }
    }
}
// swiftlint:enable nesting
