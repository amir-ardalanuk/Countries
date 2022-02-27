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
    func openCountryList(configuration: CountryList.Configuration)
}

class HomeRouter: HomeRouting {
    weak var viewController: UIViewController?
    
    var homeViewController: HomeViewController {
        return viewController as! HomeViewController
    }
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func openCountryList(configuration: CountryList.Configuration) {
        let countryListViewController = CountryListModule().makeScene(configuration: configuration)
        countryListViewController.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(countryListViewController, animated: true)
    }
}
