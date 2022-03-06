//
//  File.swift
//  
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Combine

public enum NewsFavoriteUsecaseError: Error {
    case errorOnSavingNews
    case invalidData(Error?)
}

public protocol NewsFavoriteUsecase {
    func save(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError>
    func favorites() -> AnyPublisher<[News], NewsFavoriteUsecaseError>
    func remove(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError>
    func isFavorite(news: News) -> AnyPublisher<Bool, NewsFavoriteUsecaseError>
}
