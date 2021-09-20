//
//  File.swift
//  
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation
import Extensions

extension API {
    
    public enum Character: AppNetworkable {
        case list(CharacterResponse.Request)
        
        public var request: URLRequest {
            switch self {
            case let .list(request):
                return getRequest(url: API.getURL(with: "characters"),
                                  queryItems: API.queryItems(dict: request.dictionary),
                                  headers: [:])

            }
        }
    }
}
