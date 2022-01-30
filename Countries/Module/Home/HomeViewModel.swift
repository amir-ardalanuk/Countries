//
//  ViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

protocol HomeViewModel {
    func send(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var countryListRouter: CountryListRouter { get }
}

enum HomeAction: Int, Equatable {
    case openCountryList
}

struct HomeState {
    
}

class DefaultHomeViewModel: HomeViewModel {
    var countryListRouter: CountryListRouter
    var state: CurrentValueSubject<HomeState, Never> = .init(.init())
    

    init(countryListRouter: CountryListRouter) {
        self.countryListRouter = countryListRouter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: HomeAction) {
        self.countryListRouter.openCountryList { updatedList in
            
        }
    }
}

