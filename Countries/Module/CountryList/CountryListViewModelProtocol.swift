//
//  CountryListViewModelProtocol.swift
//  Countries
//
//  Created by ardalan on 2/27/22.
//

import UIKit
import Combine
import Core

protocol CountryListRoutingAction {
    var routeAction: PassthroughSubject<CountryListRouteAction, Never> { get set }
}

protocol CountryListViewModelProtocol: CountryListRoutingAction {
    var state: CurrentValueSubject<CountryListState, Never> { get set }
    func send(action: CountryListAction)
}

enum CountryListRouteAction {
    case close
}

enum CountryListAction: Equatable {
    case fetchCountry
    case updateCountryList([Country])
    case toggleSelected(Country)
    case search(String)
    case cancelSearch
    case doneChoosing
}

struct CountryListState {
    var selectedCountries: [Country]
    var countries: [MarkableCountryViewModel]
    var isLoading: Bool
}

extension CountryListState {
    static var  emptyState: Self {
        return .init(selectedCountries: [], countries: [], isLoading: false)
    }
    
    func update(selectedCountries: [Country]) -> Self {
        return .init(selectedCountries: selectedCountries, countries: self.countries, isLoading: self.isLoading)
    }
    
    func update(viewModels: [MarkableCountryViewModel]) -> Self {
        return .init(selectedCountries: self.selectedCountries, countries: viewModels, isLoading: self.isLoading)
    }
    
    func update(loading: Bool) -> Self {
        return .init(selectedCountries: self.selectedCountries, countries: self.countries, isLoading: loading)
    }
}
