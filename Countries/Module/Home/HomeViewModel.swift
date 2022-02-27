//
//  ViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

class HomeViewModel: HomeViewModelProtocol {
    var routeAction: PassthroughSubject<HomeRouteAction, Never> = .init()
    var currentState: HomeState {
        return state.value
    }
    var countryUsecase: CountryUsecase
    var state: CurrentValueSubject<HomeState, Never> = .init(.init(selectedCountry: []))
    
    
    init(config: Home.Configuration) {
        self.countryUsecase = config.countryUseCase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handel Receive Actions
    private func openCountryList() {
        let config = CountryList.Configuration(countryUseCase: countryUsecase, updatedList: { [weak self] updatedList in
            self?.handel(action: .updateList(updatedList))
        }, selectedCountries: state.value.selectedCountry.map(\.country))
        routeAction.send(.openCountryList(config))
    }
    
    func handel(action: HomeAction) {
        switch action {
        case .openCountryList:
            openCountryList()
        case let .updateList(updatedList):
            state.value = .init(
                selectedCountry: updatedList.map { DefaultCountryCellViewModel(country: $0) }
            )
        }
    }
}

