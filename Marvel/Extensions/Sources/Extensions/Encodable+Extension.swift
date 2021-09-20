//
//  Encodable+Extension.swift
//  
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation

public extension Encodable {
    var dictionary: [String: String] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (
            try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
        )
        .flatMap { $0 as? [String: String] } ?? [:]
    }
}

