//
//  ListEventsTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 09/02/2022.
//

import UIKit

class ListEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numbersDaysLabel: UILabel!
    @IBOutlet weak var nameEventsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(nameEvents: String, numbersDays: String, date: String) {
        nameEventsLabel.text = nameEvents
        numbersDaysLabel.text = numbersDays
        dateLabel.text = date
    }
}
