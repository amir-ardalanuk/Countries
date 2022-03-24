//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit
import Core
import Combine

protocol HomeRouting: Router {
    func openCountryList(configuration: CountryListModule.Configuration)
}

final class HomeRouter: HomeRouting {
    weak var viewController: UIViewController?
    
    private var homeViewController: HomeViewController {
        return viewController as! HomeViewController
    }
    
    init() {}
    
    func openCountryList(configuration: CountryListModule.Configuration) {
        let countryListViewController = CountryListModule.makeScene(configuration: configuration)
        countryListViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(countryListViewController, animated: true)
    }
}
