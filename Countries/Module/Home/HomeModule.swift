//
//  HomeFeature.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation
import Core

enum Home {
    struct Configuration {
        let countryUseCase: CountryUsecase
    }
}

class HomeModule: FeatureModule {
    typealias Controller = HomeViewController
    typealias Configuration = Home.Configuration
    
    func makeScene(configuration: Home.Configuration) -> Controller {
        let viewController = HomeViewController()
        let router = HomeRouter(viewController: viewController)
        let viewModel = viewModelBuilder(router: router, configuration: configuration)
        
        viewController.viewModel = viewModel
        router.viewController = viewController
        
        return viewController
    }
    
    private func viewModelBuilder(router: HomeRouting, configuration: Home.Configuration) -> HomeViewModelProtocol {
        HomeViewModel(router: router, config: configuration)
    }
}
