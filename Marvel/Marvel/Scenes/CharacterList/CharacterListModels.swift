//
//  CharacterListModels.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import API

// swiftlint:disable nesting
enum CharacterList {
    
    enum ListType {
        case vertical
        case grid
    }
    
    enum FetchCharacters {
        
        struct Request {
            
        }
        
        struct Response {
            let characters: [CharacterItem]
            let isSearchActive: Bool
        }
        
        struct ViewModel {
            let characters: [CharacterCellModel]
            let isSearchActive: Bool
            
            struct CharacterCellModel {
                let image: String
                let name: String
                let seriesCount: String
                let id: Int
            }
        }
        
    }
    
    enum FetchSearch {
        struct Request {
            let searchText: String
        }
    }
    
    enum FetchCharacterSelection {
        struct Request {
            let index: Int
        }
    }
}
// swiftlint:enable nesting
