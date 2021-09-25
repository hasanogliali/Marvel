//
//  CharacterDetailModels.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import API

// swiftlint:disable nesting
enum CharacterDetail {
    
    enum Sections: Int, CaseIterable {
        case poster
        case buttons
        case comics
        case events
        case stories
        case series
    }
    
    enum FetchDetail {
        
        struct Request {
            
        }
        
        struct Response {
            let character: CharacterItem?
        }
        
        struct ViewModel {
            let id: Int
            let name: String
            let image: String
            let comics: [String]
            let events: [String]
            let stories: [String]
            let series: [String]
        }
    }
}
// swiftlint:enable nesting
