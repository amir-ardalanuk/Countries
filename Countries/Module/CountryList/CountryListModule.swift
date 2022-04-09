//
//  CountryListModule.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation
import Core

enum CountryListModule: FeatureModule {
    struct Configuration: Equatable {
        static func == (lhs: CountryListModule.Configuration, rhs: CountryListModule.Configuration) -> Bool {
            lhs.selectedCountries.elementsEqual(rhs.selectedCountries)
        }
        
        let countryUseCase: CountryUsecase
        var updatedList: ([Country]) -> ()
        var selectedCountries: [Country]
    }
    
    typealias Controller = CountryListViewController
    
    static func makeScene(configuration: Configuration) -> CountryListViewController {
        let router = CountryListRouter()
        let viewModel = CountryListViewModel(configuration: configuration)
        let viewController = CountryListViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        
        return viewController
    }

}
