//
//  NewListViewModel.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Combine

protocol NewsListViewModelProtocol {
    var state: CurrentValueSubject<NewsListViewModelState, NewsListViewModelError> { get }
    func action(_ action:NewsListViewModelAction)
}

struct NewsListViewModelState { }

enum NewsListViewModelAction {
    case fetchNews
}

enum NewsListViewModelError: Error { }

final class NewsListViewModel: NewsListViewModelProtocol {
    var state: CurrentValueSubject<NewsListViewModelState, NewsListViewModelError> = .init(.init())
    
    init(configuration: NewsList.Configuration) {
        
    }
    
    func action(_ action: NewsListViewModelAction) {
        
    }
    
    private func fetchNews() {
        
    }
}
