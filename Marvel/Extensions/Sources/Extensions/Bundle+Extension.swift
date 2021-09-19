//
//  Bundle+Extensions.swift
//  
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation

public extension Bundle {
    func infoForKey(_ key: String) -> String? {
        (infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
}
