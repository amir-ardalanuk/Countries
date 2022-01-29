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
            if let error = error {
                completion(.failure(.networkError(error)))
            } else {
                do {
                    completion(.success(try CountryItemsMapper.map(data: data, response: response)))
                } catch {
                    completion(.failure(.invalidData(error)))
                }
            }
        }
    }
}

private class CountryItemsMapper {
    static func map(data: Data?, response: URLResponse?) throws -> [Country] {
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            throw CountryUsecaseError.invalidData
        }
        
        guard httpResponse.statusCode == 200 else {
            //FIXME: make bettter error description
            throw CountryUsecaseError.invalidData
        }
        
        let countryItems = try JSONDecoder().decode([CountryItem].self, from: data)
        return countryItems.map { item -> Country in
            Country.init(
                id: item.name,
                name: item.name,
                flag: item.flag,
                region: item.region,
                capital: item.capital.first ?? "-")
        }
    }
}
