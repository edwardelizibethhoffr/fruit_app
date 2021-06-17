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
    
    private var fruits: [Fruit] = [Fruit(type: "Test")]

    var body: some View {
        NavigationView {
            List(fruits, id: \.id){
                fruit in
                NavigationLink(destination: FruitDetailView(viewModel: FruitDetailViewModel(fruit: fruit))) {
                    Text(fruit.type)
                }
            }
            .navigationBarTitle(FruitAppStrings.fruitListTitle.localised())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
