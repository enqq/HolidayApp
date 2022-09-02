//
//  HolidayTableViewCell.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 02/09/2022.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String, date: String) {
        nameLabel.text = name
        dateLabel.text = date
    }
    
}
