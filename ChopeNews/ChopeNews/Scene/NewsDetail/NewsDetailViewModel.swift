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
    case updateFavorite
}

struct NewsDetailViewModelState {
    let news: News
    let isFav: Bool
    
    func update(favState: Bool) -> Self {
        .init(news: self.news, isFav: favState)
    }
}

final class NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    var state: CurrentValueSubject<NewsDetailViewModelState, Never>
    let configuration: NewsDetail.Configuration
    let newsFavoriteUsecases: NewsFavoriteUsecase
    
    init(configuration: NewsDetail.Configuration) {
        self.newsFavoriteUsecases = configuration.favoriteUsecases
        self.configuration = configuration
        self.state = .init(.init(news: configuration.news, isFav: false))
        
        newsFavoriteUsecases.isFavorite(news: configuration.news)
            .replaceError(with: false)
            .sink { [weak self] fav in
                guard let self = self else { return }
                self.state.value = self.state.value.update(favState: fav)
            }.store(in: &cancellables)
    }

    // MARK: - Handel action
    func action(_ action: NewsDetailViewModelAction) {
        switch action {
        case .updateFavorite:
            toggleFav()
        }
    }
    
    func toggleFav() {
        let news = state.value.news
        newsFavoriteUsecases.isFavorite(news: news).flatMap { [weak self] isFavorite -> AnyPublisher<Bool, Never> in
            guard let self = self else {
                return Just(isFavorite).eraseToAnyPublisher()
            }
            if isFavorite {
                return self.newsFavoriteUsecases.remove(news: news)
                    .map { !isFavorite }
                    .replaceError(with: isFavorite)
                    .eraseToAnyPublisher()
            } else {
                return self.newsFavoriteUsecases.save(news: news)
                    .map { !isFavorite }
                    .replaceError(with: isFavorite)
                    .eraseToAnyPublisher()
            }
        }
        .sink { completion in
            print(completion)
        } receiveValue: { [weak self] state in
            guard let self = self else { return }
            self.state.value = self.state.value.update(favState: state)
        }


    }

}
