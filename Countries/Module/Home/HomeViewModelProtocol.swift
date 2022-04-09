//
//  HomeViewModelProtocol.swift
//  Countries
//
//  Created by ardalan on 2/27/22.
//

import Foundation
import Core
import Combine

//MARK: - Base Protocol
protocol HomeViewModelProtocol: HomeViewModelRoutingAction {
    func handel(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var currentState: HomeState { get }
}

protocol HomeViewModelRoutingAction {
    var routeAction: PassthroughSubject<HomeRouteAction, Never> { get set }
}

enum HomeRouteAction: Equatable {
    case openCountryList(CountryListModule.Configuration)
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
