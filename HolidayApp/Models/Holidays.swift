//
//  Holidays.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 26/08/2022.
//

import Foundation

struct Holidays {
    let holidays: [Holiday]
}

extension Holidays: Decodable {
    enum HolidaysCodingKeys: CodingKey {
        case holidays
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HolidaysCodingKeys.self)
        holidays = try container.decode([Holiday].self, forKey: .holidays)
    }
}
/// Single element Holidays List
struct Holiday {
    let name: String
    let date: String
    let observed: String
    let country: String
    let weekday: Day
    let weekdayObserved: Day
}
///  Empty model from initializer
extension Holiday {
    init() {
        name = ""
        date = ""
        observed = ""
        country = ""
        weekday = .init()
        weekdayObserved = .init()
    }
}
extension Holiday: Decodable {
    private enum HolidayCodingkeys: CodingKey {
        case name, date, observed, country, weekday
    }
    
    private enum WeekdayCodingKeys: CodingKey {
        case date, observed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HolidayCodingkeys.self)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        observed = try container.decode(String.self, forKey: .observed)
        country = try container.decode(String.self, forKey: .country)
        
        let weekdayContainer = try container.nestedContainer(keyedBy: WeekdayCodingKeys.self, forKey: .weekday)
        weekday = try weekdayContainer.decode(Day.self, forKey: .date)
        weekdayObserved = try weekdayContainer.decode(Day.self, forKey: .observed)
    }
}
/// Nested element weekday(date and observed)
struct Day: Decodable {
    let name: String
    let numeric: String
}

///  Empty model from initializer
extension Day {
    init() {
        name = ""
        numeric = ""
    }
}

