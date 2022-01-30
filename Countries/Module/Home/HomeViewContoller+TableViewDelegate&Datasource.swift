//
//  HomeViewContoller+TableViewDelegate&Datasource.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryCell.self)) as? CountryCell else {
            return UITableViewCell()
        }
        let cellViewModel = self.viewModel.currentState.selectedCountry[indexPath.row]
        cell.config(viewModel: cellViewModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.currentState.selectedCountry.count
    }
}
