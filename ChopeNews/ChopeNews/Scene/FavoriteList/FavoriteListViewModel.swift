//
//  FavoriteListViewModel.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Combine
import Core

protocol FavoriteListViewModelProtocol: BaseViewModel {
    var state: CurrentValueSubject<FavoriteListViewModelState, FavoriteListViewModelError> { get }
    func action(_ action: FavoriteListViewModelAction)
}

struct FavoriteListViewModelState {
    let newsList: Loadable<[News]>
    let routeAction: RouteAction?
    
    private init(newsList: Loadable<[News]>, route: RouteAction? = nil) {
        self.newsList = newsList
        self.routeAction = route
    }
}


extension FavoriteListViewModelState {
    func update(_ list: Loadable<[News]>) -> Self {
        .init(newsList: list)
    }
    
    func update(route: RouteAction) -> Self {
        .init(newsList: self.newsList, route: route)
    }
    
    static var initialState: Self {
        .init(newsList: .loaded([]))
    }
}

enum FavoriteListRouteAction {
    case openNewsDetail(NewsDetail.Configuration)
}

enum FavoriteListViewModelAction {
    case fetch
    case failedFetching(Error)
    case fetchCompleted([News])
    case didSelectNews(IndexPath, News)
}

enum FavoriteListViewModelError: Error { }

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    // MARK: - Properties
    private let limit = 25
    private let favUsecase: NewsFavoriteUsecase
    private let configuration: FavoriteList.Configuration
    var cancellables = Set<AnyCancellable>() {
        didSet {
            print(" ===== > CANCELLABLES")
            print(cancellables.count)
            print(" =====  CANCELLABLES")
        }
    }
    
    var state: CurrentValueSubject<FavoriteListViewModelState, FavoriteListViewModelError>
    
    // MARK: - Initialization
    init(configuration: FavoriteList.Configuration) {
        self.configuration = configuration
        state = .init(.initialState)
        favUsecase = configuration.favoriteUsecases
    }
    
    // MARK: - Action handler
    func action(_ action: FavoriteListViewModelAction) {
        switch action {
        case .fetch:
            fetchNews()
        case let .failedFetching(error):
            print(error)
            break
        case let .fetchCompleted(data):
            state.value = state.value.update(.loaded(data))
        case let .didSelectNews(_, news):
            let configuration = NewsDetail.Configuration(news: news, favoriteUsecases: configuration.favoriteUsecases)
            state.value = state.value.update(route: .openNewsDetail(configuration))
        }
    }
    
    private func fetchNews() {
        guard !(state.value.newsList.isLoading) else { return }
        state.value = state.value.update(.isLoading(last: state.value.newsList.value))
        return favUsecase.favorites()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // FIXME: error handeling
            } receiveValue: { [weak self] values in
                self?.action(.fetchCompleted(values))
            }.store(in: &cancellables)
    }
}
