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
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MarkableCountryCell {
    static var reuseableName: String {
        String(describing: Self.self)
    }
}
