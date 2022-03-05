#if DEBUG
//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

extension Pagination {
    static func stub(
        total: Int,
        offset: Int,
        limit: Int,
        count: Int
    ) -> Self {
        .init(limit: limit, offset: offset, count: count, total: total)
    }
}

#endif
