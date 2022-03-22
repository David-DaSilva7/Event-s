//
//  AttendeesTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 03/02/2022.
//

import UIKit

class AttendeesTableViewCell: UITableViewCell {

    var cellDelegate: YourCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        design()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
    @IBOutlet weak var namesAttendees: UIButton!
    
    @IBAction func buttonNames(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }
    
    
    func configure(name: String) {
        namesAttendees.setTitle("\(name)", for: .normal)
    }
    func design() {
        namesAttendees.layer.cornerRadius = 16
//        viewDesign.layer.backgroundColor = InfoEvents.randomColor
    }
}

protocol YourCellDelegate : AnyObject {
    func didPressButton(_ tag: Int)
}
