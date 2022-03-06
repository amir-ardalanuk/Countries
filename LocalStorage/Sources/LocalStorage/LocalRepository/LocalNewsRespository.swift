//
//  LcoalNewsReposistoryProtocol.swift
//  
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Core
import Combine

public protocol LocalNewsFavoriteUsecasesProtocol: NewsFavoriteUsecase {}

public class LocalNewsFavoriteUsecase: LocalNewsFavoriteUsecasesProtocol {
    let storage: Storage
    private let newsKey = "news_key"
    
    public init(storage: Storage) {
        self.storage = storage
    }
    
    public convenience init() {
        self.init(storage: UserDefaultHelper.init(useDefault: .standard))
    }
    
    public func save(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        return favorites().flatMap { currentNews -> AnyPublisher<Void, NewsFavoriteUsecaseError> in
            if currentNews.contains(where: { $0.url == news.url}) {
                return Just(())
                    .mapError { _ -> NewsFavoriteUsecaseError in }
                    .eraseToAnyPublisher()
            } else {
                var newList = currentNews
                newList.append(news)
                return Deferred { [weak self] in
                    Future<Void, NewsFavoriteUsecaseError> { promise in
                        guard let self = self else{ return }
                        self.storage.save(newList, forKey: self.newsKey) { state in
                            promise(state ? .success(()) : .failure(.errorOnSavingNews))
                        }
                    }
                }.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
    public func favorites() -> AnyPublisher<[News], NewsFavoriteUsecaseError> {
        return Deferred {
            Future<[News], NewsFavoriteUsecaseError> { [weak self] promise in
                guard let self = self else { return }
                self.storage.fetch(forKey: self.newsKey) { (result: Result<[News], StorageError>) in
                    switch result {
                    case let .success(data):
                        promise(.success(data))
                    case let .failure(error):
                        promise(.failure(.invalidData(error)))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func remove(news: News) -> AnyPublisher<Void, NewsFavoriteUsecaseError> {
        return favorites().flatMap { currentNews -> AnyPublisher<Void, NewsFavoriteUsecaseError> in
            if let index = currentNews.firstIndex(where: { $0.url == news.url}) {
                var newList = currentNews
                newList.remove(at: index)
                return Deferred { [weak self] in
                    Future<Void, NewsFavoriteUsecaseError> { promise in
                        guard let self = self else{ return }
                        self.storage.save(newList, forKey: self.newsKey) { state in
                            promise(state ? .success(()) : .failure(.errorOnSavingNews))
                        }
                    }
                }.eraseToAnyPublisher()
            } else {
                return Just(())
                    .mapError { _ -> NewsFavoriteUsecaseError in }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
    
    public func isFavorite(news: News) -> AnyPublisher<Bool, NewsFavoriteUsecaseError> {
        return favorites().flatMap { currentNews -> AnyPublisher<Bool, NewsFavoriteUsecaseError> in
            Just(currentNews.firstIndex(where: { $0.url == news.url}) != nil)
                .mapError { _ -> NewsFavoriteUsecaseError in }
                .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
 
    func isAvailableData(forKey key: String) -> Bool {
        storage.isAvailable(key: key)
    }
}
