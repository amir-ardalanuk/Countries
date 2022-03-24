//
//  CountryListModule.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation
import Core

enum CountryListModule: FeatureModule {
    struct Configuration {
        let countryUseCase: CountryUsecase
        var updatedList: ([Country]) -> ()
        var selectedCountries: [Country]
    }
    
    typealias Controller = CountryListViewController
    
    static func makeScene(configuration: Configuration) -> CountryListViewController {
        let viewController = CountryListViewController()
        let router = CountryListRouter(viewController: viewController)
        let viewModel = CountryListViewModel(configuration: configuration)
        
        viewController.viewModel = viewModel
        viewController.router = router
        
        return viewController
    }

}
