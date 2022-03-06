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
    let routeAction: RouteAction?
    
    private init(newsList: Loadable<[NewsListViewModelState.Item]>, route: RouteAction? = nil) {
        self.newsList = newsList
        self.routeAction = route
    }
}


extension NewsListViewModelState {
    enum Item: Hashable {
        case news(News)
        case hole(Int)
    }
    
    func update(_ list: Loadable<[Item]>) -> Self {
        .init(newsList: list)
    }
    
    func update(route: RouteAction) -> Self {
        .init(newsList: self.newsList, route: route)
    }
    
    static var initialState: Self {
        .init(newsList: .loaded([.hole(0)]))
    }
}

enum RouteAction {
    case openNewsDetail(NewsDetail.Configuration)
}

enum NewsListViewModelAction {
    case fetchPage(Int)
    case failedFetching(Int?, Error)
    case fetchCompleted(Int?,[News])
    case didSelectNews(IndexPath, News)
}

enum NewsListViewModelError: Error { }

final class NewsListViewModel: NewsListViewModelProtocol {
    
    // MARK: - Properties
    private let limit = 25
    private let newsUsecase: NewsUsecase
    private let configuration: NewsList.Configuration
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
        self.configuration = configuration
        state = .init(.initialState)
        newsUsecase = configuration.newsUsecases
    }
    
    // MARK: - Action handler
    func action(_ action: NewsListViewModelAction) {
        switch action {
        case let .fetchPage(page):
            fetchNews(page: page)
        case let .failedFetching(_, error):
            print(error)
            break
        case let .fetchCompleted(nextPage, data):
            var currentList = state.value.newsList.value ?? []
            currentList.removeAll(where: { item in
                switch item {
                    case .hole: return true
                    default: return false
                }
            })
            
            let list: [NewsListViewModelState.Item] = data.map { .news($0)}
            let hole: [NewsListViewModelState.Item] = nextPage.flatMap { [.hole($0)] } ?? []
            state.value = state.value.update(.loaded( currentList +  list + hole ))
        case let .didSelectNews(_, news):
            let configuration = NewsDetail.Configuration(news: news, favoriteUsecases: configuration.favoriteUsecases)
            state.value = state.value.update(route: .openNewsDetail(configuration))
        }
    }
    
    private func fetchNews(page: Int) {
        guard !(state.value.newsList.isLoading) else { return }
        state.value = state.value.update(.isLoading(last: state.value.newsList.value))
        return newsUsecase.fetchNews(offset: page, limit: limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self?.action(.failedFetching(page, error))
                }
            } receiveValue: { [weak self] (list, nextPage)  in
                self?.action(.fetchCompleted(nextPage, list))
            }.store(in: &cancellables)

    }
}
