//
//  NewListViewModel.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Combine
import Core

protocol NewsListViewModelProtocol: BaseViewModel {
    var state: CurrentValueSubject<NewsListViewModelState, NewsListViewModelError> { get }
    func action(_ action:NewsListViewModelAction)
}

struct NewsListViewModelState {
    let newsList: Loadable<[Item]>
}


extension NewsListViewModelState {
    enum Item: Hashable {
        case news(News)
        case hole(Int?)
    }
    
    func update(_ list: Loadable<[Item]>) -> Self {
        return .init(newsList: list)
    }
    
    static var initialState: Self {
        .init(newsList: .loaded([.hole(nil)]))
    }
}

enum NewsListViewModelAction {
    case fetchPage(Int?)
    case failedFetching(Int?, Error)
    case fetchCompleted(Int?,[News])
}

enum NewsListViewModelError: Error { }

final class NewsListViewModel: NewsListViewModelProtocol {
    
    // MARK: - Properties
    private let newsUsecase: NewsUsecase
    var cancellables = Set<AnyCancellable>() {
        didSet {
            print(" ===== > CANCELLABLES")
            print(cancellables.count)
            print(" =====  CANCELLABLES")
        }
    }
    var state: CurrentValueSubject<NewsListViewModelState, NewsListViewModelError>
    
    // MARK: - Initialization
    init(configuration: NewsList.Configuration) {
        state = .init(.initialState)
        newsUsecase = configuration.newsUsecases
    }
    
    // MARK: - Action handler
    func action(_ action: NewsListViewModelAction) {
        switch action {
        case let .fetchPage(page):
            fetchNews(page: page)
        case let .failedFetching(page, error):
            // FIXME: handel
            print(error)
            break
        case let .fetchCompleted(page, data):
            // FIXME: handel
            state.value = state.value.update(.loaded(data.map { .news($0)}))
            break
        }
    }
    
    private func fetchNews(page: Int?) {
        return
        newsUsecase.fetchNews(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self?.action(.failedFetching(page, error))
                }
            } receiveValue: { [weak self] list in
                self?.action(.fetchCompleted(page, list))
            }.store(in: &cancellables)

    }
}
