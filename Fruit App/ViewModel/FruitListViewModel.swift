//
//  FruitListViewModel.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation
import Combine

class FruitListViewModel: NavigationLoggingObject, ObservableObject, FruitListViewModelProtocol {
    
    private let apiService: APIServiceProtocol
    
    @Published var dataSource: [FruitDetailViewModel] = []
    
    @Published var isLoading: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private let logger: LoggerProtocol
    
    init(apiService: APIServiceProtocol, logger: LoggerProtocol) {
        self.apiService = apiService
        self.logger = logger
        super.init()
        getFruit()
    }

    func getFruit() {
        isLoading = true
        apiService.makeGetFruitRequest()
            .map { response in
                response.fruit.map(FruitDetailViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    [weak self] value in
                    self?.isLoading = false
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.logError(message:"FruitListViewModel.getFruit makeGetFruitRequest receiveCompletion  \(error.localizedDescription)")
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: {
                    [weak self] fruitList in
                    guard let self = self else { return }
                    self.dataSource = fruitList
                })
            .store(in: &disposables)
    }
    
    private func logError(message: String) {
        logger.makeLoggingRequest(eventType: UsageEventType.error, data: message)
    }
}
