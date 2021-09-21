//
//  CharacterListModels.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import API

// swiftlint:disable nesting
enum CharacterList {
    
    enum FetchCharacters {
        
        struct Request {
            
        }
        
        struct Response {
            let characters: [CharacterItem]
        }
        
        struct ViewModel {
            let characters: [CharacterCellModel]
            var listType: ListType = .vertical
            
            enum ListType {
                case vertical
                case grid
            }
            
            struct CharacterCellModel {
                let image: String
                let name: String
                let seriesCount: String
            }
        }
        
    }
    
    enum FetchSearch {
        struct Request {
            let searchText: String
        }
    }
}
// swiftlint:enable nesting
