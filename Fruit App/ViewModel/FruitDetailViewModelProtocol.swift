//
//  FruitDetailViewModelProtocol.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import Foundation

protocol FruitDetailViewModelProtocol {
    func getType() -> String
    
    func getFormattedPriceString() -> String
    
    func getFormattedWeightString() -> String
}
