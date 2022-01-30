//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine
import Core

protocol CountryListViewModel {
    typealias Router = CountryListRouter
    
    func send(action: CountryListAction)
    var state: CurrentValueSubject<CountryListState, Never> { get }
    var router: Router { get }
    var completeEditing: (([Country]) -> Void)? { get set }
}

enum CountryListAction: Int, Equatable {
    case openCountryList
}

struct CountryListState {
    
}

class DefaultCountryListViewModel: CountryListViewModel {
    var router: CountryListViewModel.Router
    var state: CurrentValueSubject<CountryListState, Never> = .init(.init())
    var completeEditing: (([Country]) -> Void)?

    init(router: CountryListViewModel.Router) {
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: CountryListAction) {
        
    }
}

