//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit

protocol HomeRoute {
    func makeHome() -> UIViewController
}

extension HomeRoute where Self: Router {
    func makeHome() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = DefaultHomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        router.root = viewController

        let navigation = UINavigationController(rootViewController: viewController)
        return navigation
    }
}

extension DefaultRouter: HomeRoute {}
