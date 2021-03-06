//
//  FruitDetailView.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI

struct FruitDetailView: View {
        
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let viewModel: FruitDetailViewModelProtocol
    
    var logBackNavigation: (() -> Void)?
    
    var body: some View {
        VStack {
            Text(viewModel.getType().capitalized)
                .font(.largeTitle)
                .padding(.bottom, 100)
            VStack(alignment: .leading) {
                HStack {
                    Image("till-icon-96")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:60)
                        .padding(12)
                    Text(viewModel.getFormattedPriceString())
                        .font(.title)
                        .padding(12)
                }
                .background(Color.green)
                .cornerRadius(15)
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image("scales-icon-96")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:60)
                        .padding(12)
                    Text(viewModel.getFormattedWeightString())
                        .font(.title)
                        .padding(12)
                }
                .background(Color.yellow)
                .cornerRadius(15)
                .frame(maxWidth: .infinity)
            }
            .fixedSize(horizontal: true, vertical: false)
            
        }
        .navigationBarTitle(Text(viewModel.getType().capitalized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.logNavigationEnded()
        }
        .navigationBarItems(leading: UIDevice.current.userInterfaceIdiom != .pad ? AnyView(self.customBackButton) : AnyView(EmptyView()))
        }
    
    var customBackButton: some View {
        Button(action : {
                self.logBackNavigation?()
                self.mode.wrappedValue.dismiss()
                    }){
                        Text("Back")
            }
    }
    
}

struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FruitDetailViewModel(fruit:Fruit(type: "Test Fruit", price: 12002, weight: 1000))
        FruitDetailView(viewModel: viewModel)
    }
}
