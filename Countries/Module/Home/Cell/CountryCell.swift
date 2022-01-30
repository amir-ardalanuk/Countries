//
//  CountryCell.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import UIKit

class CountryCell: UITableViewCell {

    
    //MARK: - Views
    
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: CountryCellViewModel? {
        didSet {
            setupViewData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Config ViewModel
    func config(viewModel: CountryCellViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - setup Views Data
    func setupViewData() {
        self.nameLabel.text = self.viewModel?.country.name
        self.flagLabel.text = self.viewModel?.country.flag
    }
    
}
