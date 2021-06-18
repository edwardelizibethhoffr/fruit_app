//
//  JSONParser.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation
import Combine


func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, FruitError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    print(data)
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            print(error.localizedDescription)
            return .parsing(description: "\(error.localizedDescription)")
        }
        .eraseToAnyPublisher()
}

