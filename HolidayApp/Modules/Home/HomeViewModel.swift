//
//  HomeViewModel.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    var input: Input
    
    var output: Output
    
    struct Input {
        /// Tap select button
        let selectButton: AnyObserver<Void>
        /// Tap search button
        let searchButton: AnyObserver<Void>
        /// Tap clear button
        let clearButton: AnyObserver<Void>
        /// Selected Country
        let selectedCountry: AnyObserver<Country>
    }
    
    struct Output {
        /// Taped select button
        let selectButton: Observable<Void>
        /// Selected Country
        let selectedCountry: Driver<Country>
    }
    
   private let selectButtonPublish = PublishSubject<Void>()
   private let searchButtonPublish = PublishSubject<Void>()
   private let clearButtonPublish = PublishSubject<Void>()
   private let selectedCountryPublish = PublishSubject<Country>()
    
    init() {
        
        let countryDriver = selectedCountryPublish
            .asDriver(onErrorJustReturn: Country())
        

        
        self.input = Input(selectButton: selectButtonPublish.asObserver(), searchButton: searchButtonPublish.asObserver(), clearButton: clearButtonPublish.asObserver(), selectedCountry: selectedCountryPublish.asObserver())
        
        self.output = Output(selectButton: selectButtonPublish.asObservable(), selectedCountry: countryDriver)
  
        clearButtonPublish.subscribe(onNext: { [weak self] in
            self?.selectedCountryPublish.onNext(.init())
        })
        .disposed(by: disposeBag)
        
    }
}
