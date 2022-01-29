#if DEBUG
//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

extension CountryItem {
    static func stub(
        name: String = "name",
        flag: String = "flag",
        region: String = "region",
        capital: [String] = ["capital"],
        area: Int = 0
    ) -> CountryItem {
        .init(name: name, region: region, flag: flag, capital: capital, area: area)
    }
}

#endif
