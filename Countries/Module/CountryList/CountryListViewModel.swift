//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

final class CountryListViewModel: CountryListViewModelProtocol {
    //MARK: - Properties
    private var cancellabe = Set<AnyCancellable>()
    private var countriesCach = [Country]()
    private var countryUsecase: CountryUsecase
    private let configuration: CountryListModule.Configuration
    var routeAction = PassthroughSubject<CountryListRouteAction, Never>()
    var state: CurrentValueSubject<CountryListState, Never>
    //MARK: - Initialize
    
    init(configuration: CountryListModule.Configuration) {
        self.state = .init(.init(selectedCountries: configuration.selectedCountries, countries: [], isLoading: false))
        self.countryUsecase = configuration.countryUseCase
        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    
    func handel(action: CountryListAction) {
        switch action {
        case .fetchCountry:
            fetchCountryList()
        case let .updateCountryList(list):
            updateCountryList(list)
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
    
    // MARK: - updating Country List
    private func updateCountryList(_ list: [Country]) {
        let currentState = state.value
        let viewModels = generateViewModels(list, selectedCountries: state.value.selectedCountries)
        self.state.value = .init(
            selectedCountries: currentState.selectedCountries,
            countries: viewModels,
            isLoading: false
        )
    }
    //MARK: - Searching
    private func search(_ text: String) {
        let filterdCountries = countriesCach.filter { $0.name.contains(text) }
        let viewModels = generateViewModels(filterdCountries, selectedCountries: state.value.selectedCountries)
        state.value = state.value.update(viewModels: viewModels)
    }
    
    //MARK: - Generate ViewModels
    private func generateViewModels(_ list: [Country], selectedCountries: [Country]) -> [MarkableCountryViewModel] {
        let selectedIds = selectedCountries.map { $0.id}
        return list.map {
            DefaultMarkableCountryViewModel(
                isSelected: selectedIds.contains($0.id),
                didSelect: { [_country = $0, weak self] in
                    self?.handel(action: .toggleSelected(_country))
                },
                country: $0
            )
        }
    }
    
    // MARK: - Update Selected List
    private func updateSelectedList(withToggle country: Country) {
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
        state.value = state.value.update(loading: true)
        countryUsecase.fetchCountryList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    // FIXME: assign to the error message
                    print(error)
                }
            } receiveValue: { [weak self] countryList in
                self?.countriesCach = countryList
                self?.handel(action: .updateCountryList(countryList))
            }.store(in: &cancellabe)
    }
    
}

