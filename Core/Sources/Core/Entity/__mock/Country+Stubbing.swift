//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public extension Country {
    static func stub(
        id: String = UUID().uuidString,
        name: String = "name",
        flag: String = "flag",
        region: String = "region",
        capital: String = "capital"
    ) -> Country {
        .init(id: id, name: name, flag: flag, region: region, capital: capital)
    }
}
