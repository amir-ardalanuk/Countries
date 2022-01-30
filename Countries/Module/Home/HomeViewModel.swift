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
}

//MARK: - Action
enum HomeAction: Int, Equatable {
    case openCountryList
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
    
    var countryListRouter: CountryListRouter
    var state: CurrentValueSubject<HomeState, Never> = .init(.init(selectedCountry: []))
    

    init(countryListRouter: CountryListRouter) {
        self.countryListRouter = countryListRouter
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: HomeAction) {
        switch action {
        case .openCountryList:
            countryListRouter.openCountryList { [weak self] updatedList in
                self?.state.value = .init(
                    selectedCountry: updatedList.map { DefaultCountryCellViewModel(country: $0) }
                )
            }
        }
    }
}

