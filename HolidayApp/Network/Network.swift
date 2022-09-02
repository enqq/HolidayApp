//
//  Network.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 20/08/2022.
//

import Foundation

struct Network: Networking {
    
    func fetchData(url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error: error!))
                return
            }
            guard let data = data else {
                completionHandler(.empty)
                return
            }
            completionHandler(.success(data: data))
        }
        task.resume()
    }
    
    func fetchParseResponse<T: Decodable>(url: URL, completionHandler: @escaping (NetworkResult<T>) -> ()) {
        fetchData(url: url) { networkResult in
            switch networkResult {
            case .success(let data):
                do{
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(data: object))
                } catch let error {
                    printError(error: error)
                    completionHandler(.failure(error: error))
                }
            case .empty:
                completionHandler(.empty)
            case .failure(let error):
                printError(error: error)
                completionHandler(.failure(error: error))
            }
        }
    }
    
    private func printError(error: Error) {
        print(error)
    }
        
}
