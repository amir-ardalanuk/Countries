//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

struct NewsResponse : Decodable {
    let pagination : Pagination?
    let data : [RemoteNews]?
}
