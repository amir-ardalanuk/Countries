//
//  NewsUsecases.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Combine

public enum NewsUsecaseError: Error {
    case invalidData(Error?)
    case networkError(Error)
}

public protocol NewsUsecase {
    typealias NewsResult = (list: [News], nextPage: Int?)
    func fetchNews(offset: Int, limit: Int) -> AnyPublisher<NewsResult, NewsUsecaseError>
}
