#if DEBUG
//
//  MockHTTPClient.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public final class MockHTTPClient: HTTPClient {
    
    public init() { }
    
    public var resultProvider: (Data, HTTPURLResponse)?
    
    public func request(_ request: URLRequest, completion: @escaping (Data, HTTPURLResponse) -> Void) {
        if let provider = resultProvider {
            completion(provider.0, provider.1)
        }
        
        fatalError("Not prepare result provider for mock request")
    }
}

#endif
