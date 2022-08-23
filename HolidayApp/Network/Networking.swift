//
//  Networking.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 20/08/2022.
//

import Foundation

enum NetworkResult<T> {
    case success(data: T)
    case empty
    case failure(error: Error)
}

protocol Repositories {
    associatedtype Endpoint: RawRepresentable where Endpoint.RawValue: StringProtocol
}

protocol Networking {

    func fetchData(url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) -> Void
    func fetchParseResponse<T: Decodable>(url: URL, completionHandler: @escaping (NetworkResult<T>) -> Void)
   
}

