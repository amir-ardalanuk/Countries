//
//  FavoriteListModule.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Core

enum FavoriteList {
    struct Configuration {
        let favoriteUsecases: NewsFavoriteUsecase
    }
}

class FavoriteListModule: FeatureModule {
    typealias Controller = FavoriteListViewController
    typealias Configuration = FavoriteList.Configuration
    
    func makeScene(configuration: FavoriteList.Configuration) -> Controller {
        let viewModel = FavoriteListViewModel(configuration: configuration)
        let router = FavoriteListRouter()
        let viewController = FavoriteListViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
