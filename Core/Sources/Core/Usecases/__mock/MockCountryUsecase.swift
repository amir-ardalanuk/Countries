#if DEBUG
//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public final class MockCountryListUsecases: CountryUsecase {

    public init() {}
    
    public var resultProvider: (() -> Result<[Country], CountryUsecaseError>)?
    
    public func fetchCountryList(completion: @escaping CountryListCompletion) {
        if let result = resultProvider?() {
            completion(result)
        }
        completion(.success([.stub()]))
    }

}

#endif
