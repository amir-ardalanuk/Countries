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
    func makeHome() -> UIViewController
}

extension HomeRoute where Self: Router {
    func makeHome() -> UIViewController {
        let router = DefaultRouter(rootTransition: PushTransition())
        let viewModel = DefaultHomeViewModel(countryListRouter: router)
        let viewController = HomeViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        router.root = viewController
        return navigation
    }
}

extension DefaultRouter: HomeRoute {}
