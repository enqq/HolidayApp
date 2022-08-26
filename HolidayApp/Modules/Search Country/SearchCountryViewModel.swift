//
//  SearchCountryViewModel.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchCountryViewModel: ViewModelType {
    var input: Input
    var output: Output
    
    struct Input {
        /// Emits writes text in SearchBar
        let searchText: AnyObserver<String>
        /// Taped country row in TableView
        let selectedCountry: AnyObserver<Country>
    }
    
    struct Output {
        /// Return cuntries list
        let countries: Driver<[Country]>
        /// Emits selected country
        let selectedCountry: Observable<Country>
    }
    
    private let searchTextPublish = PublishSubject<String>()
    private let selectedCountryPublish = PublishSubject<Country>()
    
    init(repository: HolidayRepository = HolidayRepository()) {
        
       let countriesDriver = Observable.combineLatest(searchTextPublish.asObservable(), repository.fetchCountries())
            .map{ (searchText, countries) -> [Country] in
                if searchText.count > 1 {
                    return countries.country
                        .filter{ $0.name.contains(searchText) || $0.code.lowercased().contains(searchText.lowercased())
                        }
                } else {
                    return countries.country
                }
            }
            .asDriver(onErrorJustReturn: [])
        
        input = Input(searchText: searchTextPublish.asObserver(), selectedCountry: selectedCountryPublish.asObserver())
        output = Output(countries: countriesDriver, selectedCountry: selectedCountryPublish.asObservable())
    }
    
}
