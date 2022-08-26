//
//  Countries.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 20/08/2022.
//

import Foundation

/// MARK: Countries List
struct Countries {
    let country: [Country]
}

extension Countries: Decodable {
    private enum CountriesCodingKeys: String, CodingKey {
        case country = "countries"
    }
    
    init(from decoder: Decoder) throws {
        let conainer = try decoder.container(keyedBy: CountriesCodingKeys.self)
        
        country = try conainer.decode([Country].self, forKey: .country)
    }
}

///  MARK: Single element Countries list
struct Country {
    let name: String
    let code: String
}

extension Country {
    init() {
        name = ""
        code = ""
    }
}

extension Country: Decodable {
   private  enum CountryCodingKeys: String, CodingKey {
        case name
        case code
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CountryCodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
    }
}
