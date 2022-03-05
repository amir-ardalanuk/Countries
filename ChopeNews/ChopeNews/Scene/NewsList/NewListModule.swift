//
//  NewListModule.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Core

enum NewsList {
    struct Configuration {
        let apiKey: String
        let newsUsecases: NewsUsecase
    }
}

class NewsListModule: FeatureModule {
    typealias Controller = NewsListViewController
    typealias Configuration = NewsList.Configuration
    
    func makeScene(configuration: NewsList.Configuration) -> Controller {
        let viewModel = NewsListViewModel(configuration: configuration)
        let router = NewsListRouter()
        let viewController = NewsListViewController(viewModel: viewModel, router: router)
        
        router.viewController = viewController // Property Injection
        
        return viewController
    }
}
