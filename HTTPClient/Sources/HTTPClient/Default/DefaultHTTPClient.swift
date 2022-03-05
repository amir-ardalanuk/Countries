//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Combine

public class DefaultHTTPClient: HTTPClient {
    let urlSession: URLSession
    
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func request(_ request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error> {
        return urlSession.dataTaskPublisher(for: request)
            .map { output -> (Data, URLResponse) in
                output // (data, response)
            }
            .mapError{ error -> Error in error}
            .eraseToAnyPublisher()
    }
    
    private func request(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
