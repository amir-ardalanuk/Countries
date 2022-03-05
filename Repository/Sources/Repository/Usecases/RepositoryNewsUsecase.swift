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

public class RepositoryNewsUsecase: NewsUsecase {


    
    let remoteUsecases: RemoteNewsUsecasesProtocol
    
    public init(remoteUsecases: RemoteNewsUsecasesProtocol) {
        self.remoteUsecases = remoteUsecases
    }

    public func fetchNews(offset: Int, limit: Int) -> AnyPublisher<NewsResult, NewsUsecaseError> {
        // FIXME: Could be added `LocalUsecases` or decide to bring data from local/cache or load from remote
        remoteUsecases.fetchNews(offset: offset, limit: limit)
    }
}
