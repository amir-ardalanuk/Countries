//
//  CountryListViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import UIKit
import Combine

class CountryListViewController: UIViewController {
    //MARK: - Properties
    var viewModel: CountryListViewModelProtocol!
    var router: CountryListRouting!
    private var cancellable = Set<AnyCancellable>()

    // MARK: - View's
    lazy var searchBar: UISearchBar = { [unowned self] in
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = { [unowned self] in
        let view = UITableView(frame: self.view.frame)
        view.delegate = self
        view.dataSource = self
        view.register(
            .init(nibName: MarkableCountryCell.reuseableName, bundle: nil),
            forCellReuseIdentifier: MarkableCountryCell.reuseableName
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.refreshControl = self.refresher
        
        return view
    }()
    
    lazy var refresher: UIRefreshControl =  { [unowned self] in
        var controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(refreshDidChange(_:)), for: .valueChanged)
        return controller
    }()
    
    lazy var doneBarButtonItem: UIBarButtonItem = { [unowned self] in
        let doneAction = UIBarButtonItem(systemItem: .done, primaryAction: nil, menu: nil)
        doneAction.target = self
        doneAction.action = #selector(didTapOnDone(_:))
        return doneAction
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Choose Country"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
        bindViewModel()
        navigationItem.rightBarButtonItem = doneBarButtonItem
        viewModel.handel(action: .fetchCountry)
    }
    
    //MARK: - Selectors
    @objc private func refreshDidChange(_ sender: Any) {
        viewModel.handel(action: .fetchCountry)
    }
    
    @objc private func didTapOnDone(_ sender: Any) {
        viewModel.handel(action: .doneChoosing)
    }
    
    //MARK: - setup Views
    
    func setupViews() {
        view.backgroundColor = .white
        [tableView, searchBar]
            .forEach(view.addSubview(_:))
    }
    
    //MARK: - setup Constraint
    
    func setupConstraint() {
        let searchBarConstraint = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
        NSLayoutConstraint.activate(searchBarConstraint)
        
        let tableViewConstraint = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(tableViewConstraint)
    }
    
    //MARK: - setup Observer
    
    func bindViewModel() {
        viewModel.state
            .map(\.isLoading)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.refresher.beginRefreshing()
                } else {
                    self?.refresher.endRefreshing()
                }
                
            }
            .store(in: &cancellable)
        
        viewModel.state
            .sink { [weak self] homeState in
            //FIXME: it's better to use diffable datasource and batchUpdate to reload only cells have been changed.
            self?.tableView.reloadData()
        }.store(in: &cancellable)
        
        viewModel.routeAction.sink(receiveValue: { [weak self] action in
            switch action {
            case .close:
                self?.router.close()
            }
        }).store(in: &cancellable)
    }
}

//MARK: - Searchbar Delegate
extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.handel(action: .cancelSearch)
        } else {
            self.viewModel.handel(action: .search(searchText))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.handel(action: .cancelSearch)
    }
}
