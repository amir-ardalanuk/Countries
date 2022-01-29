//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public enum CountryUsecaseError: Error {
    case invalidData(Error?)
    case networkError(Error)
}

public protocol CountryUsecase {
    
    typealias CountryListCompletion = ((Result<[Country], CountryUsecaseError>) -> ())
    
    func fetchCountryList(completion: CountryListCompletion)
}
