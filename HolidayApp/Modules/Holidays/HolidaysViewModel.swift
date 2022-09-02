//
//  HolidaysViewModel.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 26/08/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class HolidaysViewModel: ViewModelType {
    let input: Input
    let output: Output
    
    struct Input {
        ///  Taped holiday in tableView
        let selectedHoliday: AnyObserver<Holiday>
    }
    
    struct Output {
        /// Return fetch holidays list
        let holidays: Driver<[Holiday]>
        /// Emit taped in tableView
        let selectedHoliday: Observable<Holiday>
    }
    
    private let selectedHolidayPublish = PublishSubject<Holiday>()
    
    init(_ countryCode: String, repository: HolidayRepository = HolidayRepository()) {
        
        let holidaysDriver = repository.fetchHolidays(countryCode)
            .map({ $0.holidays })
            .asDriver(onErrorJustReturn: [])

        input = Input(selectedHoliday: selectedHolidayPublish.asObserver())
        output = Output(holidays: holidaysDriver, selectedHoliday: selectedHolidayPublish.asObservable())
    }
    
}
