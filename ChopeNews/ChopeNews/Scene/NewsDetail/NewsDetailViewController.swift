//
//  NewsDetailViewController.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import UIKit
import Combine

final class NewsDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let router: NewsDetailRouting
    let viewModel: NewsDetailViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: NewsDetailViewModelProtocol, router: NewsDetailRouting) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    // MARK: - Bind
    func bind() {
        
    }
    
    // MARK: - SetupView
    func setupView() {
        
    }
}
