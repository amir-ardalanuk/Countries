//
//  CountryItem.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

struct CountryItem: Decodable {
    // MARK: - Properties
    
    let name: String
    let region: String
    let flag: String?
    let capital: [String]
    
    // MARK: - Initializing
    init(name: String, region: String, flag: String?, capital: [String]) {
        self.name = name
        self.region = region
        self.flag = flag
        self.capital = capital
    }
    
    // MARK: - Decoding
    
    enum RootKey: String, CodingKey {
        case name
        case region
        case flag
        case capital
    }
    
    enum NameKey: String, CodingKey {
        case official
        case common
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        self.flag = try container.decodeIfPresent(String.self, forKey: .flag)
        self.region = try container.decode(String.self, forKey: .region)
        
        var capitalContainer = try? container.nestedUnkeyedContainer(forKey: .capital)
        var capitalList = [String]()
        while !(capitalContainer?.isAtEnd ?? true) {
            if let capital = try capitalContainer?.decode(String.self) {
                capitalList.append(capital)
            }
        }
        self.capital = capitalList
        
        let nameContainer = try container.nestedContainer(keyedBy: NameKey.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .common)
    }
}
