//
//  NewsListViewController.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import UIKit
import Combine

fileprivate struct Constant {
    static let title = "News"
}
fileprivate enum Layout {
    static let rowHeight: CGFloat = 70.0
}

class NewsListViewController: UIViewController {
    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: NewsListViewModelProtocol
    private let router: NewsListRouting
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Layout.rowHeight
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    init(viewModel: NewsListViewModelProtocol, router: NewsListRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - SetupView
    private func setupView() {
        title = Constant.title
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        let tablewViewConstriant = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(tablewViewConstriant)
    }
    
    // MARK: - bind ViewModel
    private func bind() {
        viewModel.state
            .map(\.newsList.value)
            .replaceError(with: [])
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellable)
        
        viewModel.state
            .map(\.routeAction)
            .replaceError(with: nil)
            .compactMap { $0 }
            .sink { [weak self] route in
                switch route {
                case let .openNewsDetail(config):
                    self?.router.openNewsDetail(configuration: config)
                }
            }.store(in: &cancellable)

    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentNews.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let values = viewModel.currentNews.value else {
            fatalError()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.contentConfiguration = viewModel.map(item: values[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemType = viewModel.currentNews.value?[indexPath.row] else {
            return
        }
        switch itemType {
        case let .news(news):
            viewModel.action(.didSelectNews(indexPath, news))
        case .hole:
            break
        }
        
    }
}


fileprivate extension NewsListViewModelProtocol {
    var currentNews: Loadable<[NewsListViewModelState.Item]> {
        state.value.newsList
    }
    
    func map(item: NewsListViewModelState.Item) -> UIContentConfiguration? {
        switch item {
        case let .news(data):
            return NewsRowConfiguration(news: data)
        case let .hole(page):
            let config = HoleRowConfiguration(page: page)
            config.load.sink { [weak self] page in
                guard let page = page else { return }
                self?.action(.fetchPage(page))
            }.store(in: &cancellables)
            return config
        }
    }
    
}
