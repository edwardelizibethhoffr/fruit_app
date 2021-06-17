//
//  ContentView.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    //private var fruits: FetchedResults<Fruit>
    
    private var fruits: [Fruit] = [Fruit(type: "Test Fruit", price: 12002, weight: 1000)]

    var body: some View {
        NavigationView {
            List(fruits, id: \.id){
                fruit in
                NavigationLink(destination:
                                FruitDetailView(viewModel: FruitDetailViewModel(fruit: fruit))) {
                    Text(fruit.type)
                        .font(.title)
                        .padding(12)
                }
            }
            .navigationBarTitle(FruitAppStrings.fruitListTitle.localised())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
