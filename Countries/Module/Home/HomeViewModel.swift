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
    typealias Router = HomeRoute
    
    func send(action: HomeAction)
    var state: CurrentValueSubject<HomeState, Never> { get }
    var router: Router { get }
}

enum HomeAction: Int, Equatable {
    case openCountryList
}

struct HomeState {
    
}

class DefaultHomeViewModel: HomeViewModel {
    var router: HomeViewModel.Router
    var state: CurrentValueSubject<HomeState, Never> = .init(.init())
    

    init(router: HomeViewModel.Router) {
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func send(action: HomeAction) {
        
    }
}

