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

    @ObservedObject private var viewModel = FruitListViewModel(apiService: APIService(), logger: Logger())
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
           NavigationView {
                List {
                    if viewModel.dataSource.isEmpty {
                        noResultsSection
                    }
                    else {
                        ForEach(viewModel.dataSource, id: \.self, content: {
                            vm in
                            return FruitRow(fruitVM: vm, logBackNavigation: {
                                self.viewModel.logNavigationStarted()
                            })
                        })
                    }
                }
                .toolbar {
                    Button(FruitAppStrings.fruitListRefresh.localised()) {
                        viewModel.getFruit()
                    }
                }
                .onAppear {
                    viewModel.logNavigationEnded()
                }
                .navigationBarTitle(FruitAppStrings.fruitListTitle.localised())
                EmptyDetailView()
            }
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

struct EmptyDetailView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Fruit app!")
                .font(.largeTitle)
                .padding(.bottom, 100)
        }
    }
}

struct FruitRow: View {
    
    @ObservedObject var fruitVM: FruitDetailViewModel

    @State private var selection: Int?
    
    var logBackNavigation: (() -> Void)?
    
    func selectionBinding() -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.selection
        }, set: {
            self.selection = $0
            fruitVM.logNavigationStarted()
        })
        return binding
    }
    
    var body: some View {
        NavigationLink(destination:
                        NavigationLazyView (
                            FruitDetailView(viewModel: fruitVM, logBackNavigation: {
                                self.logBackNavigation?()
                            })),
                       tag: 1,
                       selection: selectionBinding()
        ) {
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


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
