//
//  File.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation

public class DefaultHTTPClient: HTTPClient {
    let urlSession: URLSession
    
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    public func request(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
