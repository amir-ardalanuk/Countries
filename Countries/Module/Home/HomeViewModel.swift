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
protocol HomeViewModel {
    func send(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var currentState: HomeState { get }
    var countryListRouter: CountryListRouter { get }
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

class DefaultHomeViewModel: HomeViewModel {
    var currentState: HomeState {
        return state.value
    }
    var countryUsecase: CountryUsecase
    var countryListRouter: CountryListRouter
    var state: CurrentValueSubject<HomeState, Never> = .init(.init(selectedCountry: []))
    
    
    init(countryListRouter: CountryListRouter, countryUsecase: CountryUsecase) {
        self.countryListRouter = countryListRouter
        self.countryUsecase = countryUsecase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: HomeAction) {
        switch action {
        case .openCountryList:
            countryListRouter.openCountryList(
                viewData: .init(
                    countryUsecases: countryUsecase,
                    selectedCountry: state.value.selectedCountry.map(\.country),
                    completion: { [weak self] updatedList in
                        self?.send(action: .updateList(updatedList))
                        
                    }
                )
            )
        case let .updateList(updatedList):
            state.value = .init(
                selectedCountry: updatedList.map { DefaultCountryCellViewModel(country: $0) }
            )
        }
    }
}

