//
//  File.swift
//  
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Core
import HTTPClient
import Combine

public protocol RemoteNewsUsecasesProtocol: NewsUsecase { }

public class RemoteNewsUsecase: RemoteNewsUsecasesProtocol {
    private let client: HTTPClient
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func fetchNews(offset: Int, limit: Int) -> AnyPublisher<NewsResult, NewsUsecaseError> {
        // FIXME: It's better to use wrraper for making request somthing like Moya
        var urlComponent = URLComponents(string: MediStack.news.path)
        urlComponent?.queryItems = [
            URLQueryItem(name: "access_key", value: MediStack.accessKey),
            URLQueryItem(name: "languages", value: "en"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
        ]
        guard let endpointUrl = urlComponent?.url else {
            fatalError("URL is not correct")
        }
        let request = URLRequest(url: endpointUrl)
        return client.request(request)
            .tryMap {
                try Self.map(data: $0.0, response: $0.1)
            }
            .mapError { error in
                switch error {
                case let usecaseError as NewsUsecaseError:
                    return usecaseError
                default:
                    return NewsUsecaseError.networkError(error)
                }
                
            }.eraseToAnyPublisher()
    }
}

private extension NewsUsecase {
    static func map(data: Data?, response: URLResponse?) throws -> NewsResult {
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            throw NewsUsecaseError.invalidData(nil)
        }
        
        guard httpResponse.statusCode == 200 else {
            //FIXME: make bettter error description
            throw NewsUsecaseError.invalidData(nil)
        }
        
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+ 'HH:mm"
        let newsList = newsResponse.data?.map { item -> News in
            let date: Date = dateFormatter.date(from: item.publishedAt) ?? Date()
            return News(
                author: item.author,
                title: item.title,
                description: item.description,
                url: item.url,
                source: item.source,
                image: item.image,
                category: item.category,
                language: item.language,
                country: item.country,
                publishedAt:  date
            )
        } ?? []

        let nextPage = newsResponse.pagination.flatMap { ($0.offset + $0.count) <= $0.total ? $0.offset + $0.count : nil }
        return NewsResult(list: newsList, nextPage: nextPage)
    }
}
