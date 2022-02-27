//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

class CountryListViewModel: CountryListViewModelProtocol {
    //MARK: - Properties
    var routeAction = PassthroughSubject<CountryListRouteAction, Never>()
    var state: CurrentValueSubject<CountryListState, Never>
    var countryUsecase: CountryUsecase
    var configuration: CountryList.Configuration
    private var countriesCach = [Country]()
    
    
    //MARK: - Initialize
    
    init(configuration: CountryList.Configuration) {
        self.state = .init(.init(selectedCountries: configuration.selectedCountries, countries: [], isLoading: false))
        self.countryUsecase = configuration.countryUseCase
        self.configuration = configuration
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
            let viewModels = generateViewModels(array, selectedCountries: state.value.selectedCountries)
            self.state.value = .init(
                selectedCountries: currentState.selectedCountries,
                countries: viewModels,
                isLoading: false
            )
        case .toggleSelected(let country):
            updateSelectedList(withToggle: country)
        case let .search(text):
            search(text)
        case .cancelSearch:
            let viewModels = generateViewModels(countriesCach, selectedCountries: state.value.selectedCountries)
            state.value = state.value.update(viewModels: viewModels)
        case .doneChoosing:
            configuration.updatedList(state.value.selectedCountries)
            routeAction.send(.close)
        }
    }
    
    //MARK: - Searching
    func search(_ text: String) {
        let filterdCountries = countriesCach.filter { $0.name.contains(text) }
        let viewModels = generateViewModels(filterdCountries, selectedCountries: state.value.selectedCountries)
        state.value = state.value.update(viewModels: viewModels)
    }
    
    //MARK: - Generate ViewModels
    func generateViewModels(_ list: [Country], selectedCountries: [Country]) -> [MarkableCountryViewModel] {
        let selectedIds = selectedCountries.map { $0.id}
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
            .update(viewModels: generateViewModels(currentState.countries.map(\.country), selectedCountries: newCountries))
    }
    // MARK: - Fetch Countries
    
    private func fetchCountryList() {
        //FIXME: call api
        state.value = self.state.value.update(loading: true)
        countryUsecase.fetchCountryList { [weak self] result in
            switch result {
            case let .success(values):
                DispatchQueue.main.async { [weak self] in
                    self?.countriesCach = values
                    self?.send(action: .updateCountryList(values))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}

