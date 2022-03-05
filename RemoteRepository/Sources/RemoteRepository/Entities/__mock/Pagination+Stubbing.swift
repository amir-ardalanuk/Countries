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
        limit: Int?,
        offset: Int?,
        count: Int?,
        total: Int?
    ) -> Self {
        .init(limit: limit, offset: offset, count: count, total: total)
    }
}

#endif
