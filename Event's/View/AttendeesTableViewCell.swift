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
        design()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var namesAttendeesLabel: UILabel!
    @IBOutlet weak var viewDesign: UIView!
    
    
    func configure(name: String) {
        namesAttendeesLabel.text = name
    }
    func design() {
        viewDesign.layer.cornerRadius = 16
//        viewDesign.layer.backgroundColor = InfoEvents.randomColor
    }
}
