//
//  File.swift
//  
//
//  Created by ardalan on 3/6/22.
//

import Foundation
let serverDateFormatter : DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+ 'HH:mm"
    return formatter
}()

extension Date {
    static func make(withServerDate dateString: String) throws -> Self {
        let date = serverDateFormatter.date(from: dateString)
        guard let _date = date else {
            throw NSError(domain: "DateString not in a correct format", code: -100)
        }
        return _date
    }
}

