//
//  MarkableCountryCell.swift
//  Countries
//
//  Created by Amir Ardalani on 1/30/22.
//

import UIKit

class MarkableCountryCell: UITableViewCell {

    //MARK: - View
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    //MARK: - Properties
    var viewModel: MarkableCountryViewModel? {
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
    func config(_ viewModel: MarkableCountryViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - setup Views Data
    func setupViewData() {
        self.viewModel.flatMap {
            self.nameLabel.text = $0.country.name
            self.flagLabel.text = $0.country.flag
            self.checkmarkImageView.image = $0.isSelected ? #imageLiteral(resourceName: "ic_circle_mark") : #imageLiteral(resourceName: "ic_circle")
        }
    }
}

extension MarkableCountryCell {
    static var reuseableName: String {
        String(describing: Self.self)
    }
}
