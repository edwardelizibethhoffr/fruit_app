//
//  Fruit.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation

struct Fruit: Decodable, Encodable {
    var type: String
    var price: Int
    var weight: Int
}
