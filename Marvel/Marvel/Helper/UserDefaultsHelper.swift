//
//  UserDefaultsHelper.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

import Foundation

struct UserDefaultsHelper {
    
    enum DefaultsKeys: String {
        case characterIds = "Character_Ids"
    }
    
    struct Favorites {
        static func contains(_ id: Int) -> Bool {
            return favoritedChacters.contains(id)
        }
        
        static func handleFavorite(_ id: Int) {
            if contains(id) {
                removeFromFavorite(id)
            } else {
                addToFavorite(id)
            }
        }
        
        private static var favoritedChacters: [Int] {
            UserDefaults.standard.object(forKey: DefaultsKeys.characterIds.rawValue) as? [Int] ?? []
        }
        
        private static func addToFavorite(_ id: Int) {
            var characters = favoritedChacters
            characters.append(id)
            UserDefaults.standard.set(characters, forKey: DefaultsKeys.characterIds.rawValue)
        }
        
        private static func removeFromFavorite(_ id: Int) {
            var characters = favoritedChacters
            characters.removeAll { $0 == id }
            UserDefaults.standard.set(characters, forKey: DefaultsKeys.characterIds.rawValue)
        }
    }
    
    struct Character {
        static func save<T: Codable>(_ object: T, with key: String) {
            do {
                let data = try JSONEncoder().encode(object)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        static func isCharacterSaved(_ key: String) -> Bool {
            guard let _ = UserDefaults.standard.data(forKey: key) else {
                return false
            }
            return true
        }
    }
}
