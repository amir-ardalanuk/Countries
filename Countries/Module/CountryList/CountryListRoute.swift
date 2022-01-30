//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit
import Core

protocol CountryListRouter {
    func openCountryList(completion: @escaping ([Country]) -> Void)
}

extension CountryListRouter where Self: Router {
    func openCountryList(with transition: Transition) {
        let router = DefaultCountryListRouter(rootTransition: transition)
        let viewModel = DefaultCountryListViewModel(router: router)
        viewModel.completeEditing = { [weak router] list in
            router?.completion?(list)
        }
        let viewController = CountryListViewController(viewModel: viewModel)
        router.root = viewController

        route(to: viewController, as: transition)
    }
    
    func openCountryList(completion: @escaping ([Country]) -> Void) {
        openCountryList(with: PushTransition())
    }
}

extension DefaultRouter: CountryListRouter {}

final class DefaultCountryListRouter: DefaultRouter {
    var completion: (([Country]) -> Void)?
}

