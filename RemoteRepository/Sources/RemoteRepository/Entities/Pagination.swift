//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

struct Pagination : Decodable {
    let limit : Int?
    let offset : Int?
    let count : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {
        case limit = "limit"
        case offset = "offset"
        case count = "count"
        case total = "total"
    }
}
