//
//  Date+Extension.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation

private let shortDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY/MM/dd"
    return dateFormatter
}()

private let fullDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY/MM/dd HH:mm"
    return dateFormatter
}()


extension Date {
    var shortDateString: String? {
        return shortDateFormatter.string(from: self)
    }
    
    var fullDateString: String? {
        return fullDateFormatter.string(from: self)
    }
}
