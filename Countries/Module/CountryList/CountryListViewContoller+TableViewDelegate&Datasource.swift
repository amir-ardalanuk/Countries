//
//  CountryListViewContoller+TableViewDelegate&Datasource.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarkableCountryCell.reuseableName) as? MarkableCountryCell else {
            return UITableViewCell()
        }
        cell.config(viewModel.state.value.countries[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.value.countries.count
    }
}
