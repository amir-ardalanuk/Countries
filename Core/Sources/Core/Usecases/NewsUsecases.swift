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
    
    func fetchNews(page: Int?) -> AnyPublisher<[News], NewsUsecaseError>
}
