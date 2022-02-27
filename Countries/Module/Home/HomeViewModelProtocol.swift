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
protocol HomeViewModelProtocol: HomeViewModelRoutingDataSource {
    func handelAction(_ action: HomeAction)
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
