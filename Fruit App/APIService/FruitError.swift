//
//  FruitError.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation

enum FruitError: Error {
    case parsing(description: String)
    case network(description: String)
}
