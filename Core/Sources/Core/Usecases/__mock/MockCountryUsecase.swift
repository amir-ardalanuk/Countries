#if DEBUG
//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Combine

public final class MockCountryListUsecases: CountryUsecase {

    public init() {}
    
    public var resultProvider: (() -> Result<[Country], CountryUsecaseError>)?
    
    public func fetchCountryList() -> AnyPublisher<[Country], CountryUsecaseError> {
        if let result = resultProvider?() {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }

}

#endif
