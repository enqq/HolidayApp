//
//  DetailsHolidayViewModel.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 02/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsHolidayViewModel: ViewModelType {
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
        let holiday: Driver<Holiday>
    }
    
    init(holiday: Holiday) {
        let holidayDriver = Driver.just(holiday)
        
        input = Input()
        output = Output(holiday: holidayDriver)
    }
}
