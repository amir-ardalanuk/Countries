//
//  NewsDetailViewModel.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Combine
import Core

protocol NewsDetailViewModelProtocol: BaseViewModel {
    var state: CurrentValueSubject<NewsDetailViewModelState, Never> { get set }
    func action(_ action: NewsDetailViewModelAction)
}

enum NewsDetailViewModelAction {
    
}

struct NewsDetailViewModelState {
    let news: News
}

final class NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    var state: CurrentValueSubject<NewsDetailViewModelState, Never>
    let configuration: NewsDetail.Configuration
    
    init(configuration: NewsDetail.Configuration) {
        self.configuration = configuration
        self.state = .init(.init(news: configuration.news))
    }

    // MARK: - Handel action
    func action(_ action: NewsDetailViewModelAction) {
        
    }

}
