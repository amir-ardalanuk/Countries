//
//  MarkableCountryViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import Core

protocol MarkableCountryViewModel {
    var isSelected: Bool { get }
    var didSelect: (() -> Void)? { get }
    var country: Country { get }
}

extension MarkableCountryViewModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.country.id == rhs.country.id {
            return lhs.isSelected == rhs.isSelected
        } else {
            return false
        }
    }
}


final class DefaultMarkableCountryViewModel: MarkableCountryViewModel {
    var isSelected: Bool
    var didSelect: (() -> Void)?
    var country: Country
    
    
    init(isSelected: Bool, didSelect: (() -> Void)? = nil, country: Country) {
        self.isSelected = isSelected
        self.didSelect = didSelect
        self.country = country
    }
    
}
