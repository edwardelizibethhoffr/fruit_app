//
//  FruitDetailViewModelTests.swift
//  Fruit AppTests
//
//  Created by Calum Maclellan on 20/06/2021.
//

@testable import Fruit_App
import XCTest

class FruitDetailViewModelTests: XCTestCase {

    var viewModel: FruitDetailViewModel!
    var fruit: Fruit!
    
    override func setUpWithError() throws {
        fruit = Fruit(type: "TestFruit", price: 21, weight: 99)
        
        viewModel = FruitDetailViewModel(fruit: fruit)
    }

    func testGetTypeReturnsExpectedValue() {
        XCTAssertEqual(viewModel.getType(), fruit.type)
    }
    
    func testGetFormattedPriceStringReturnsExpectedValue() {
        XCTAssertEqual(viewModel.getFormattedPriceString(), "£ 0.21")
        
        fruit = Fruit(type: "TestFruit", price: 21999, weight: 99)
        viewModel = FruitDetailViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.getFormattedPriceString(), "£ 219.99")
        
        fruit = Fruit(type: "TestFruit", price: 0, weight: 99)
        viewModel = FruitDetailViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.getFormattedPriceString(), "£ 0.00")
    }
    
    func testGetFormattedWeightStringReturnsExpectedValue() {
        XCTAssertEqual(viewModel.getFormattedWeightString(), "0.099 Kg")
        
        fruit = Fruit(type: "TestFruit", price: 21, weight: 9999999)
        viewModel = FruitDetailViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.getFormattedWeightString(), "9,999.999 Kg")
        
        fruit = Fruit(type: "TestFruit", price: 21, weight: 0)
        viewModel = FruitDetailViewModel(fruit: fruit)
        
        XCTAssertEqual(viewModel.getFormattedWeightString(), "0.000 Kg")
    }

}
