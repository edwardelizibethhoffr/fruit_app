//
//  FruitDetailViewModel.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import Foundation

class FruitDetailViewModel: Identifiable, FruitDetailViewModelProtocol {
    
    private let fruit: Fruit
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    func getType() -> String {
        return fruit.type
    }
    
    func getFormattedPriceString() -> String {
        let priceAsString = roundToGivenDecimalPlaces(value: Double(fruit.price) / 100, decimalPlaces: 2)
        return "\(FruitAppStrings.currencyUnit.localised()) \(priceAsString)"
    }
    
    func getFormattedWeightString() -> String {
        let weightAsString = roundToGivenDecimalPlaces(value: Double(fruit.weight) / 1000, decimalPlaces: 3)
        return "\(weightAsString) \(FruitAppStrings.weightUnit.localised())"
    }
    
    private func roundToGivenDecimalPlaces(value: Double, decimalPlaces: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = decimalPlaces
        numberFormatter.maximumFractionDigits = decimalPlaces
        numberFormatter.numberStyle = .decimal
        guard let formattedNumberAsString = numberFormatter.string(from: NSNumber(value: value)) else {
            return "0"
        }
        return formattedNumberAsString
    }
    
}

extension FruitDetailViewModel: Hashable {
  static func == (lhs: FruitDetailViewModel, rhs: FruitDetailViewModel) -> Bool {
    return lhs.getType() == rhs.getType()
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.getType())
  }
}

