//
//  AttendeesTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 03/02/2022.
//

import UIKit

class AttendeesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var namesAttendeesLabel: UILabel!
    
    func configure(name: String) {
        namesAttendeesLabel.text = name
    }
}
