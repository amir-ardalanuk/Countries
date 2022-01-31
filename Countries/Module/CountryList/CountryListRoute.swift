//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit
import Core

struct CountryListViewData {
    var countryUsecases: CountryUsecase
    var selectedCountry: [Country]
    var completion: ([Country]) -> Void
}

protocol CountryListRouter {
    func openCountryList(viewData: CountryListViewData)
}

extension CountryListRouter where Self: Router {
    func openCountryList(with transition: Transition, viewData: CountryListViewData) {
        let router = DefaultCountryListRouter(rootTransition: transition)
        //FIXME: It can be handled on ViewModel with ViewData /
        router.completion = viewData.completion
        let viewModel = DefaultCountryListViewModel(router: router, countryUsecase: viewData.countryUsecases, selectedCountries: viewData.selectedCountry)
        viewModel.completeEditing = { [weak router] list in
            router?.completion?(list)
        }
        let viewController = CountryListViewController(viewModel: viewModel)
        router.root = viewController

        route(to: viewController, as: transition)
    }
    
    func openCountryList(viewData: CountryListViewData) {
        openCountryList(with: PushTransition(), viewData: viewData)
    }
}

extension DefaultCountryListRouter: CountryListRouter {}

final class DefaultCountryListRouter: DefaultRouter {
    var completion: (([Country]) -> Void)?
}

