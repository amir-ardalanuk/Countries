#if DEBUG
//
//  MockHTTPClient.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Combine

public final class MockHTTPClient: HTTPClient {
    
    public init() { }
    
    public var resultProvider: (Data?, HTTPURLResponse?, Error?)?
    
    public func request(_ request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error> {
        if let provider = resultProvider {
            if let data = provider.0, let response = provider.1 {
                return Just((data, response))
                    .mapError { failure -> Error in  }
                    .eraseToAnyPublisher()
            } else if let error = provider.2 {
                return Fail(error: error)
                    .mapError { failure -> Error in  failure }
                    .eraseToAnyPublisher()
            } else {
                fatalError("Not prepare result provider for mock request")
            }
        } else {
            fatalError("Not prepare result provider for mock request")
        }
        
        
    }
    public func request(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let provider = resultProvider {
            completion(provider.0, provider.1, provider.2)
        }
        
        fatalError("Not prepare result provider for mock request")
    }
}

#endif
