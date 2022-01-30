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
    
    // MARK: - Init
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
