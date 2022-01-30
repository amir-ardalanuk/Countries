//
//  CountryItemViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import Core

protocol CountryCellViewModel {
    var country: Country { get }
}

final class DefaultCountryCellViewModel: CountryCellViewModel {
    var country: Country
    
    init(country: Country) {
        self.country = country
    }
}
