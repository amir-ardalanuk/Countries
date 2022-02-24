//
//  ViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

//MARK: - Base Protocol
protocol HomeViewModelProtocol {
    func send(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var currentState: HomeState { get }
    var router: HomeRouting { get }
    var countryUsecase: CountryUsecase { get }
}

//MARK: - Action
enum HomeAction: Equatable {
    case openCountryList
    case updateList([Country])
}

//MARK: - State
struct HomeState {
    var selectedCountry: [CountryCellViewModel]
}

//MARK: - Concreate HomeViewModel

class HomeViewModel: HomeViewModelProtocol {
    var currentState: HomeState {
        return state.value
    }
    var countryUsecase: CountryUsecase
    var router: HomeRouting
    var state: CurrentValueSubject<HomeState, Never> = .init(.init(selectedCountry: []))
    
    
    init(router: HomeRouting, config: Home.Configuration) {
        self.router = router
        self.countryUsecase = config.countryUseCase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: HomeAction) {
        switch action {
        case .openCountryList:
            let config = CountryList.Configuration(countryUseCase: countryUsecase, updatedList: { [weak self] updatedList in
                self?.send(action: .updateList(updatedList))
            }, selectedCountries: state.value.selectedCountry.map(\.country))
            router.openCountryList(configuration: config)
        case let .updateList(updatedList):
            state.value = .init(
                selectedCountry: updatedList.map { DefaultCountryCellViewModel(country: $0) }
            )
        }
    }
}

