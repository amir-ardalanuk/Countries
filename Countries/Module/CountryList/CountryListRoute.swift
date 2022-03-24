//
//  HomeRoute.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit
import Core

struct CountryListViewData {
    var countryUsecases: CountryUsecase
    var selectedCountry: [Country]
    var completion: ([Country]) -> Void
}

protocol CountryListRouting: Router {
    func close()
}

final class CountryListRouter: CountryListRouting {
    weak var viewController: UIViewController?
    
    init() {}
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
