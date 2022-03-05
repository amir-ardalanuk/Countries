//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

enum MediStack: String {
    static let accessKey = "06b6e3279e1ae5ae0bd5e268560a1f25"
    static let baseURL = "http://api.mediastack.com/v1/"
    
    case news = "news"
    
    var path: String {
        switch self {
        case .news:
            return Self.baseURL + self.rawValue
        }
    }
}
