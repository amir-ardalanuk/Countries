//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public enum CountryUsecaseError: Error {
    case invalidData
    case networkError(Error)
}

public protocol CountryUsecase {
    
    typealias CountryListCompletion = ((Void) -> Result<Country, CountryUsecaseError>)
    
    func fetchCountryList(completion: CountryListCompletion)
}
