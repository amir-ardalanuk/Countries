//
//  RemoteCountryListUsecases.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Core
import HTTPClient
import Combine

public class RemoteCountryListUsecases: CountryUsecase {
    
    private let client: HTTPClient
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func fetchCountryList() -> AnyPublisher<[Country], CountryUsecaseError> {
        guard let endpointUrl = URL(string: "https://restcountries.com/v3.1/all") else {
            fatalError("URL is not correct")
        }
        let request = URLRequest(url: endpointUrl)
        return client.request(request)
            .tryMap {  try CountryItemsMapper.map(data: $0.0, response: $0.1) }
            .mapError { error in
                switch error {
                case let usecaseError as CountryUsecaseError:
                    return usecaseError
                default:
                    return CountryUsecaseError.networkError(error)
                }
                
            }.eraseToAnyPublisher()
    }
}

private class CountryItemsMapper {
    static func map(data: Data?, response: URLResponse?) throws -> [Country] {
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            throw CountryUsecaseError.invalidData(nil)
        }
        
        guard httpResponse.statusCode == 200 else {
            //FIXME: make bettter error description
            throw CountryUsecaseError.invalidData(nil)
        }
        
        let countryItems = try JSONDecoder().decode([CountryItem].self, from: data)
        return countryItems.map { item -> Country in
            Country.init(
                id: item.name,
                name: item.name,
                flag: item.flag ?? "🏁",
                region: item.region,
                capital: item.capital.first ?? "-")
        }
    }
}
