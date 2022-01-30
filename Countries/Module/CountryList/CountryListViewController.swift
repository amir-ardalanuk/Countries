//
//  CountryListViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import UIKit

class CountryListViewController: UIViewController {
    //MARK: - Properties
    var viewModel: CountryListViewModel
    
    // MARK: - View's
    lazy var searchBar: UISearchBar = {[unowned self] in
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }
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
    
    // MARK: - Init
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Selectors
    @objc private func refreshDidChange(_ sender: Any) {
        self.viewModel.send(action: .fetchCountry)
    }
}

//MARK: - Searchbar Delegate
extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
