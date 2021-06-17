//
//  FruitDetailView.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI

struct FruitDetailView: View {
        
    //let fruit: Fruit
    
    let viewModel: FruitDetailViewModelProtocol

    var body: some View {
        VStack {
            Text(viewModel.getType())
                .font(.largeTitle)
                .padding(.bottom, 100)
            VStack(alignment: .trailing) {
                HStack {
                    DetailsIconImage(image: Image("till-icon-96"))
                    Text(viewModel.getFormattedPriceString())
                        .font(.title)
                }
                HStack {
                    DetailsIconImage(image: Image("scales-icon-96"))
                    Text(viewModel.getFormattedWeightString())
                        .font(.title)
                }
            }
        }
        
        .navigationBarTitle(Text(viewModel.getType()), displayMode: .inline)
    }
}

struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FruitDetailViewModel(fruit:Fruit(type: "Test Fruit"))
        FruitDetailView(viewModel: viewModel)
    }
}
