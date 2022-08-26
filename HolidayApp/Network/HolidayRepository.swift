//
//  HolidayRepository.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import Foundation
import RxSwift

struct HolidayRepository {
    private let network: Network!
    
    init(network: Network = Network()){
        self.network = network
    }
    
    private let baseUrl = URL.init(string: "https://holidayapi.com/v1")
    private let apiKey = "dbedae72-0432-4dfa-8c06-ca74fb6e34b1"
    
    private enum Endpoint: String {
        case listCountries =  "countries"
    }
    
    func fetchCountries() -> Observable<Countries> {
        let url =  generateUrlFromEndpoint(endpoint: .listCountries)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
        URLQueryItem(name: "key", value: apiKey),
        ]
        
       return Observable.create { observer in
            network.fetchParseResponse(url: components.url!) { (result: NetworkResult<Countries>) in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .empty:
                    observer.onNext(Countries.init(country: []))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
           return Disposables.create()
        }
    }
}

extension HolidayRepository {
    private func generateUrlFromEndpoint(endpoint: Endpoint) -> URL {
        let url =  baseUrl?.appendingPathComponent(endpoint.rawValue)
        return url!
    }
}
