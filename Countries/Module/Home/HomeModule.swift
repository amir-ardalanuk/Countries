//
//  HomeModule.swift
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
        let viewModel = HomeViewModel(config: configuration)
        let router = HomeRouter(viewController: viewController)
        
        viewController.viewModel = viewModel
        viewController.router = router
        router.viewController = viewController
        
        return viewController
    }
}
