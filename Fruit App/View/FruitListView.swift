//
//  FruitListView.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI
import CoreData

struct FruitListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private var viewModel = FruitListViewModel(apiService: APIService())
    
    private var isLoading = false
    
    var body: some View {
        
        NavigationView {
            List {
                if viewModel.dataSource.isEmpty {
                    noResultsSection
                }
                else {
                    ForEach(viewModel.dataSource, id: \.self, content: FruitRow.init(fruitVM:))
                }
            }
            .navigationBarTitle(FruitAppStrings.fruitListTitle.localised())
            .toolbar {
                Button(FruitAppStrings.fruitListRefresh.localised()) {
                    viewModel.getFruit()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
     
        
    }
    
    var noResultsSection: some View {
       Section {
        Text(FruitAppStrings.fruitListNoResults.localised())
            .font(.title)
            .padding(12)
       }
     }
}

struct FruitRow: View {
    
    let fruitVM: FruitDetailViewModel

    var body: some View {
        NavigationLink(destination:
                    FruitDetailView(viewModel: fruitVM)) {
            Text(fruitVM.getType().capitalized)
                .font(.title)
                .padding(12)
        }
    }
}

struct FruitListView_Previews: PreviewProvider {
    static var previews: some View {
        FruitListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
