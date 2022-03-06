//
//  RepositoryNewsUsecase.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Core
import Combine
import RemoteRepository
import LocalStorage

public class RepositoryNewsUsecase {
    let remoteUsecases: RemoteNewsUsecasesProtocol
    let favoriteUsecase: LocalNewsFavoriteUsecasesProtocol
    
    public init(remoteUsecases: RemoteNewsUsecasesProtocol, favoriteUsecases: LocalNewsFavoriteUsecasesProtocol) {
        self.remoteUsecases = remoteUsecases
        self.favoriteUsecase = favoriteUsecases
    }
}

extension RepositoryNewsUsecase: NewsUsecase {
    public func fetchNews(offset: Int, limit: Int) -> AnyPublisher<NewsResult, NewsUsecaseError> {
        // FIXME: Could be added `LocalUsecases` or decide to bring data from local/cache or load from remote
        remoteUsecases.fetchNews(offset: offset, limit: limit)
    }
}

extension RepositoryNewsUsecase: NewsFavoriteUsecase {
    public func save(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        favoriteUsecase.save(news: news)
    }
    
    public func favorites() -> AnyPublisher<[News], NewsFavoriteUsecaseError> {
        favoriteUsecase.favorites()
    }
    
    public func remove(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        favoriteUsecase.remove(news: news)
    }
    
    public func isFavorite(news: News) -> AnyPublisher<Bool, NewsFavoriteUsecaseError> {
        favoriteUsecase.isFavorite(news: news)
    }
    
    
}
