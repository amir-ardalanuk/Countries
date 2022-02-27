//
//  ViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    //MARK: - Properties
    var viewModel: HomeViewModelProtocol!
    var router: HomeRouting!
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Views
    
    lazy var tableView: UITableView = { [unowned self] in
        let view = UITableView(frame: self.view.frame)
        let countryCell = String(describing: CountryCell.self)
        view.register(.init(nibName: String(describing: CountryCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CountryCell.self))
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chooseCountryButton: UIButton = { [unowned self] in
        let button = UIButton(type: .custom)
        //FIXME: Should use L10n
        button.setTitle("Choose Country", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapOnChooseCountry(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var emptyListLabel: UILabel = { [unowned self] in
        let label = UILabel()
        //FIXME: Should use L10n
        label.text = "There is not any Country"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Selected Country"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
        bindViewModel()
    }
    
    //MARK: - Selectors
    
    @objc private func didTapOnChooseCountry(_ sender: Any) {
        viewModel.handel(action: .openCountryList)
    }
    
    //MARK: - setup Views
    
    func setupViews() {
        view.backgroundColor = .white
        [tableView, chooseCountryButton, emptyListLabel]
            .forEach(view.addSubview(_:))
    }
    
    //MARK: - setup Constraint
    
    func setupConstraint() {
        let emptyListLabelConstraint = [
            emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyListLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(emptyListLabelConstraint)
        
        let chooseCountryButtonConstraint = [
            chooseCountryButton.heightAnchor.constraint(equalToConstant: 38),
            chooseCountryButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseCountryButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseCountryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(chooseCountryButtonConstraint)
        
        let tableViewConstraint = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: chooseCountryButton.topAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(tableViewConstraint)
    }
    
    //MARK: - bind viewModel
    
    func bindViewModel() {
        viewModel.state
            .map {
                !$0.selectedCountry.isEmpty
            }.sink { [weak self] isHidden in
                self?.emptyListLabel.isHidden = isHidden
            }
            .store(in: &cancellable)
        
        viewModel.state
            .sink { [weak self] homeState in
            self?.tableView.reloadData()
        }.store(in: &cancellable)
        
        // MARK: - Observing to the route action
        viewModel.routeAction.sink { [weak self] action in
            switch action {
            case let .openCountryList(config):
                self?.router.openCountryList(configuration: config)
            }
        }.store(in: &cancellable)
    }
}


