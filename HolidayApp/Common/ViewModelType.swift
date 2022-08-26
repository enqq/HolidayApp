//
//  ViewModelType.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import Foundation

protocol ViewModelType {
    var input: Input {get}
    var output: Output {get}
    
    associatedtype Input
    associatedtype Output
}
