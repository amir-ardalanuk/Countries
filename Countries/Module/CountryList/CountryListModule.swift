//
//  CountryListModule.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation
import Core
enum CountryList {
    struct Configuration {
        let countryUseCase: CountryUsecase
        var updatedList: ([Country]) -> () 
        var selectedCountries: [Country]
    }
}

class CountryListModule: FeatureModule {
    
    typealias Controller = CountryListViewController
    typealias Configuration = CountryList.Configuration
    
    func makeScene(configuration: CountryList.Configuration) -> CountryListViewController {
        let viewController = CountryListViewController()
        let router = CountryListRouter(viewController: viewController)
        let viewModel = viewModelBuilder(router: router, configuration: configuration)
        
        viewController.viewModel = viewModel
        router.viewController = viewController
        
        return viewController
    }
    private func viewModelBuilder(router: CountryListRouting, configuration: CountryList.Configuration) -> CountryListViewModelProtocol {
        CountryListViewModel(router: router, configuration: configuration)
    }
}
