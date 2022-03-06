#if DEBUG
//
//  MockNewsFavoriteUseCases.swift
//
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Combine

public final class MockNewsFavoriteUseCases: NewsFavoriteUsecase {
    
    public init() {}
    
    public var saveResultProvider: ((News) -> Result<Void, NewsFavoriteUsecaseError>)?
    public func save(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        if let result = saveResultProvider?(news) {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }
    
    public var favoritesResultProvider: (() -> Result<[News], NewsFavoriteUsecaseError>)?
    public func favorites() -> AnyPublisher<[News], NewsFavoriteUsecaseError> {
        if let result = favoritesResultProvider?() {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }
    
    public var removeResultProvider: (() -> Result<Void, NewsFavoriteUsecaseError>)?
    public func remove(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        if let result = removeResultProvider?() {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }
    
    public var isFavoriteResultProvider: ((News) -> Result<Void, NewsFavoriteUsecaseError>)?
    public func isFavorite(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        if let result = isFavoriteResultProvider?(news) {
            return result.publisher.eraseToAnyPublisher()
        }
        fatalError("No implemented result Provider")
    }

}

#endif
