//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Combine

public enum CountryUsecaseError: Error {
    case invalidData(Error?)
    case networkError(Error)
}

public protocol CountryUsecase {
    
    func fetchCountryList() -> AnyPublisher<[Country], CountryUsecaseError>
}
