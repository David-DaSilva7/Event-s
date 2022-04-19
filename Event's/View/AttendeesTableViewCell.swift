//
//  AttendeesTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 03/02/2022.
//

import UIKit

class AttendeesTableViewCell: UITableViewCell {

    // MARK: - Properties
    var cellDelegate: YourCellDelegate?

    // MARK: - Outlets
    @IBOutlet weak var namesAttendees: UIButton!
    
    // MARK: - Actions
    @IBAction func buttonNames(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }
    
    // MARK: - Functions
    // Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        design()
    }
    // Configure the different elements of the cell
    func configure(name: String) {
        namesAttendees.setTitle("\(name)", for: .normal)
    }
    // Design of the different elements
    func design() {
        namesAttendees.layer.cornerRadius = 16
    }
}

// MARK: - Protocols
protocol YourCellDelegate : AnyObject {
    // Function to know on which particpants we pressed
    func didPressButton(_ tag: Int)
}
