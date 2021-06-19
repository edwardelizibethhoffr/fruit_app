//
//  FruitListView.swift
//  Fruit App
//
//  Created by Calum Maclellan on 17/06/2021.
//

import SwiftUI
import CoreData
import Combine

struct FruitListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private var viewModel = FruitListViewModel(apiService: APIService())
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
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
    
    @ObservedObject var fruitVM: FruitDetailViewModel

    @State private var selection: Int?

        func selectionBinding() -> Binding<Int?> {
            let binding = Binding<Int?>(get: {
                self.selection
            }, set: {
                self.selection = $0
                fruitVM.navigationLogger.navigationEventStarted()
            })
            return binding
        }
    
    
    var body: some View {
        NavigationLink(destination:
                        NavigationLazyView (
                            FruitDetailView(viewModel: fruitVM)),
                       tag: 1,
                       selection: selectionBinding()
        ) {
            Text(fruitVM.getType().capitalized)
                .font(.title)
                .padding(12)
        }
        
        
            //navigationLogger.navigationEventStarted()
        
    }
}

struct FruitListView_Previews: PreviewProvider {
    static var previews: some View {
        FruitListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
