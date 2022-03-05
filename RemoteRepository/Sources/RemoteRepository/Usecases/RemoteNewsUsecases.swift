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

public class RemoteNewsUsecase: NewsUsecase {
    private let client: HTTPClient
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func fetchNews(page: Int?) -> AnyPublisher<[News], NewsUsecaseError> {
        // FIXME: It's better to use wrraper for making request somthing like Moya
        guard let endpointUrl = URL(string: "https://restcountries.com/v3.1/all") else {
            fatalError("URL is not correct")
        }
        let request = URLRequest(url: endpointUrl)
        return client.request(request)
            .tryMap {  try News.map(data: $0.0, response: $0.1) }
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

private extension News {
    static func map(data: Data?, response: URLResponse?) throws -> [News] {
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            throw NewsUsecaseError.invalidData(nil)
        }
        
        guard httpResponse.statusCode == 200 else {
            //FIXME: make bettter error description
            throw NewsUsecaseError.invalidData(nil)
        }
        
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        let dateFormatter = DateFormatter()
        /// 2021-12-07T22:58:00+00: 00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+ 'HH:mm"
        return newsResponse.data?.map { item -> News in
            let date: Date = dateFormatter.date(from: item.publishedAt) ?? Date()
            return News.init(author: item.author, title: item.title, description: item.description, url: item.url, source: item.source, image: item.image, category: item.category, language: item.language, country: item.country, publishedAt:  date)
        } ?? []
    }
}
