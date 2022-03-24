//
//  HomeModule.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation
import Core

enum HomeModule: FeatureModule {
    
    struct Configuration {
        let countryUseCase: CountryUsecase
    }
    
    typealias Controller = HomeViewController
    
    static func makeScene(configuration: Configuration) -> Controller {
        let viewModel = HomeViewModel(config: configuration)
        let router = HomeRouter()
        let viewController = HomeViewController(viewModel: viewModel, router: router)
        
        router.viewController = viewController
        
        return viewController
    }
}
