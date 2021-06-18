//
//  FruitAppStrings.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import Foundation

enum FruitAppStrings: String {
    
    case fruitListNoResults = "fruitListNoResults"
    case fruitListTitle = "fruitListTitle"
    case fruitListRefresh = "fruitListRefresh"
    
    case currencyUnit = "currencyUnit"
    case weightUnit = "weightUnit"
    
    func localised() -> String {
        rawValue.localised()
    }
}

extension String {
    
    func localised() -> String {
        return NSLocalizedString(self, tableName: "FruitAppStrings", bundle: Bundle.main, value: String(), comment: String())
    }
    
}
