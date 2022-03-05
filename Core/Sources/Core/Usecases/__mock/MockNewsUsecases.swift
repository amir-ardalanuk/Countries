#if DEBUG
//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation

import Combine

public final class MockNewsUseCases: NewsUsecase {
    public init() {}
    
    public var resultProvider: (() -> Result<[News], NewsUsecaseError>)?
    
    public func fetchNews(page: Int?) -> AnyPublisher<[News], NewsUsecaseError> {
        if let result = resultProvider?() {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }
}

#endif
