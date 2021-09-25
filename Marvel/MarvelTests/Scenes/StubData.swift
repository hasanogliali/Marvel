//
//  StubData.swift
//  CS_iOS_AssignmentTests
//
//  Created by Ali Hasanoğlu on 16.05.2021.
//  Copyright © 2021 Backbase. All rights reserved.
//

import UIKit

struct StubData {
    
    static func getDataFromLocal<T: Decodable>(fileName: String, callback: @escaping (Result<T, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(T.self, from: data)
                callback(.success(response))
                return
            } catch {
                callback(.failure(error))
                return
            }
        }
        callback(.failure(NSError(domain: "no json file", code: 400, userInfo: nil)))
    }
}
