//
//  ListEventsTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 09/02/2022.
//

import UIKit

class ListEventsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numbersDaysLabel: UILabel!
    @IBOutlet weak var nameEventsLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    // MARK: - Functions
    // Configure the different elements of the cell
    func configure(events: Event) {
        self.nameEventsLabel.text = events.name?.capitalizingFirstLetter()
        if  events.numberOfDays == 1 {
            self.numbersDaysLabel.text = "\(events.numberOfDays) jour"
        } else {
            self.numbersDaysLabel.text = "\(events.numberOfDays) jours"
        }
//        self.numbersDaysLabel.text = "\(events.numberOfDays) jours"
        self.dateLabel.text = events.date
        self.picture.image = UIImage(data: events.imageEvent)
    }
}
