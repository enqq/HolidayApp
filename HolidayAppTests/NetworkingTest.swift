//
//  NetworkingTest.swift
//  HolidayAppTests
//
//  Created by Dawid Karpiński on 20/08/2022.
//

import XCTest
@testable import HolidayApp

class NetworkingTest: XCTestCase {

    private var network: Network!
    
    override func setUp(){
        self.network = Network()
    }
    
    func testFetchDataSucces() throws {
        let url = URL.init(string: "https://holidayapi.com/v1/holidays?pretty&key=dbedae72-0432-4dfa-8c06-ca74fb6e34b1&country=PL&year=2021")
        
        let expec = expectation(description: "Data succesful")
        network.fetchData(url: url!) { result in
            switch result {
            case .success(let data):
                print(data)
                expec.fulfill()
            default:
                XCTFail("Fetch data error")
            }
        }
        
        self.wait(for: [expec], timeout: 4)

    }
    
    func testFetchCountriesListSucces() throws{
        let url = URL.init(string: "https://holidayapi.com/v1/countries?pretty&key=dbedae72-0432-4dfa-8c06-ca74fb6e34b1")
        
        let expaction = expectation(description: "Parse succes")
        
        network.fetchParseResponse(url: url!){ (result: NetworkResult<Countries>) in
            switch result {
            case .success(_):
                expaction.fulfill()
            default:
                XCTFail("Error parse data")
            }
        }
        self.wait(for: [expaction], timeout: 4)
}
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
