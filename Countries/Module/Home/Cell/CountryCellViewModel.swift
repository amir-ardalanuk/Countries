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

extension CountryCellViewModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.country.id == rhs.country.id
    }
}

final class DefaultCountryCellViewModel: CountryCellViewModel {
    var id: String {
        country.id
    }
    var country: Country
    
    init(country: Country) {
        self.country = country
    }
}
