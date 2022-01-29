//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public struct Country: Equatable {

    // MARK: - Properties
    public let id: String
    public let name: String
    public let flag: String
    public let region: String
    public let capital: String
    
    
    // MARK: - Initialize
    internal init(id: String, name: String, flag: String, region: String, capital: String) {
        self.id = id
        self.name = name
        self.flag = flag
        self.region = region
        self.capital = capital
    }
    
    
}
