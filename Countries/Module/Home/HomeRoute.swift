//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit
import Core

protocol HomeRoute {
    typealias Result = () -> [Country]
    func makeHome(countryUsecases: CountryUsecase) -> UIViewController 
}

extension HomeRoute where Self: Router {
    func makeHome(countryUsecases: CountryUsecase) -> UIViewController {
        let router = DefaultCountryListRouter(rootTransition: PushTransition())
        let viewModel = DefaultHomeViewModel(countryListRouter: router, countryUsecase: countryUsecases)
        let viewController = HomeViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        router.root = viewController
        return navigation
    }
}

extension DefaultRouter: HomeRoute {}
