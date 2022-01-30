//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

protocol CountryListViewModel {
    typealias Router = CountryListRouter
    
    func send(action: CountryListAction)
    var state: CurrentValueSubject<CountryListState, Never> { get }
    var router: Router { get }
    var completeEditing: (([Country]) -> Void)? { get set }
}

enum CountryListAction: Equatable {
    case fetchCountry
    case updateCountryList([Country])
    case toggleSelected(Country)
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
}

class DefaultCountryListViewModel: CountryListViewModel {
    //MARK: - Properties
    
    var router: CountryListViewModel.Router
    var state: CurrentValueSubject<CountryListState, Never>
    var completeEditing: (([Country]) -> Void)?
    
    //MARK: - Initialize

    init(router: CountryListViewModel.Router, selectedCountries: [Country] = []) {
        self.state = .init(.init(selectedCountries: selectedCountries, countries: [], isLoading: false))
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    func send(action: CountryListAction) {
        switch action {
        case .fetchCountry:
            fetchCountryList()
            fetchCountryList()
        case .updateCountryList(let array):
            let currentState = state.value
            let viewModels = generateViewModels(array)
            self.state = .init(
                .init(
                    selectedCountries: currentState.selectedCountries,
                    countries: viewModels, isLoading: false))
        case .toggleSelected(let country):
            updateSelectedList(withToggle: country)
        }
    }
    
    func generateViewModels(_ list: [Country]) -> [MarkableCountryViewModel] {
        let currentState = state.value
        let selectedIds = currentState.selectedCountries.map { $0.id}
        return list.map {
            DefaultMarkableCountryViewModel(
                isSelected: selectedIds.contains($0.id),
                didSelect: { [_country = $0, weak self] in
                    self?.send(action: .toggleSelected(_country))
                },
                country: $0
            )
        }
    }
    
    // MARK: - Update Selected List
    func updateSelectedList(withToggle country: Country) {
        let currentState = state.value
        var newCountries = currentState.selectedCountries
        if let index = currentState.selectedCountries.firstIndex(where: { $0.id == country.id}) {
            newCountries.remove(at: index)
        } else {
            newCountries.append(country)
        }
        state.value = state.value.update(selectedCountries: newCountries)
    }
    // MARK: - Fetch Countries
    
    private func fetchCountryList() {
        //FIXME: call api
    }
    
}

