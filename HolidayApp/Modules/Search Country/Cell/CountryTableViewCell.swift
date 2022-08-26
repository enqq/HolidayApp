//
//  CountryTableViewCell.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCountry(_ code: String, _ name: String){
        codeLabel.text = code
        nameLabel.text = name
    }
}
