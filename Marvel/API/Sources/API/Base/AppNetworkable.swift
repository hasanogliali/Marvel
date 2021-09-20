//
//  File.swift
//  
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import Foundation
import NetworkManager

public protocol AppNetworkable: Networkable {}

public extension AppNetworkable {
    func fetchResponse<V: Decodable>(
        _ type: V.Type, showLoader: Bool = true, completion: @escaping ((Result<V, Error>) -> Void)
    ) {
        self.fetch(V.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
