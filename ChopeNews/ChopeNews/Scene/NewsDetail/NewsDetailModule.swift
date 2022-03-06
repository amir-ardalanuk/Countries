//
//  NewsDetailModule.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Core


struct NewsDetail {
    struct Configuration {
        let news: News
    }
}

final class NewsDetailModule: FeatureModule {
    typealias Controller = NewsDetailViewController
    typealias Configuration = NewsDetail.Configuration
    
    func makeScene(configuration: NewsDetail.Configuration) -> NewsDetailViewController {
        let viewModel = NewsDetailViewModel(configuration: configuration)
        let router = NewsDetailRouter()
        let viewController = NewsDetailViewController(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
