//
//  APIService.swift
//  Fruit App
//
//  Created by Calum Maclellan on 18/06/2021.
//

import Foundation
import Combine

class APIService: NSObject, URLSessionTaskDelegate {
    
    private var session: URLSession!
    
    init(_ session: URLSession? = nil) {
        super.init()
        if let session = session {
            self.session = session
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default,
                                  delegate: self,
                                  delegateQueue: nil)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            makeUsageEventRequest(eventType: .error, data: error.localizedDescription)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for metric in metrics.transactionMetrics {
            if let startDate = metric.fetchStartDate, let endDate = metric.responseEndDate {
                let timeTaken = Int( endDate.timeIntervalSince(startDate) * 1000)
                print("Request took \(timeTaken)")
                if let url = task.response?.url, !url.absoluteString.contains("/stats") {
                    makeUsageEventRequest(eventType: .load, data: "\(timeTaken)")
                }
            }
        }
    }
    
    private func getBaseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/fmtvp/recruit-test-data/master"
        return components
    }

    private func getFruitDataRequestURLComponents() -> URLComponents {
        var components = getBaseURLComponents()
        components.path += "/data.json"
        return components
    }
    
    private func getStatsRequestURLComponents(eventType: UsageEventType, data: String) -> URLComponents {
        var components = getBaseURLComponents()
        components.path += "/stats"
        components.queryItems = [
            URLQueryItem(name: "event", value: eventType.rawValue),
            URLQueryItem(name: "data", value: data)
        ]
        return components
    }
}

extension APIService: APIServiceProtocol {
    
    func makeGetFruitRequest() -> AnyPublisher<FruitResponse, FruitError>{
        print("makeGetFruitRequest called")
        guard let url = getFruitDataRequestURLComponents().url else {
            let error = FruitError.network(description: "Couldn't create the URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                return .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}

extension APIService: APILoggingProtocol {
    
    func makeUsageEventRequest(eventType: UsageEventType, data: String) {
        guard let url = getStatsRequestURLComponents(eventType: eventType, data: data).url else {
            let error = FruitError.network(description: "Couldn't create the URL")
            print(error.localizedDescription)
            return
        }
        self.session.dataTask(with: URLRequest(url: url)).resume()
    }
}

enum UsageEventType: String {
    case load = "load"
    case display = "display"
    case error = "error"
}
