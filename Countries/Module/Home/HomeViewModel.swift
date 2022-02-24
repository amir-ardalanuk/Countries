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
protocol HomeViewModelProtocol: HomeViewModelRoutingDataSource {
    func send(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var currentState: HomeState { get }
}

protocol HomeViewModelRoutingDataSource {
    var routeAction: PassthroughSubject<RouteAction, Never> { get set }
}

enum RouteAction {
    case openCountryList(CountryList.Configuration)
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
    var routeAction: PassthroughSubject<RouteAction, Never> = .init()
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
    
    func send(action: HomeAction) {
        switch action {
        case .openCountryList:
            let config = CountryList.Configuration(countryUseCase: countryUsecase, updatedList: { [weak self] updatedList in
                self?.send(action: .updateList(updatedList))
            }, selectedCountries: state.value.selectedCountry.map(\.country))
            routeAction.send(.openCountryList(config))
        case let .updateList(updatedList):
            state.value = .init(
                selectedCountry: updatedList.map { DefaultCountryCellViewModel(country: $0) }
            )
        }
    }
}

