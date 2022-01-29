//
//  RemoteCountryListUsecases.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Core
import HTTPClient

public class RemoteCountryListUsecases: CountryUsecase {
    private let client: HTTPClient
    init(client: HTTPClient) {
        self.client = client
    }
    
    
    public func fetchCountryList(completion: (Result<[Country], CountryUsecaseError>) -> ()) {
        guard let endpointUrl = URL(string: "https://restcountries.com/v3.1/all") else {
            fatalError("URL is not correct")
        }
        let request = URLRequest(url: endpointUrl)
        self.client.request(request) { data, response, error in
            
        }
    }
}
