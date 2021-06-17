//
//  Fruit.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import Foundation

struct Fruit: Hashable {
    var id = UUID()
    var type: String
    var price: Int
    var weight: Int
    
    init(type: String, price: Int, weight: Int) {
        self.type = type
        self.price = price
        self.weight = weight
    }
}
