//
//  ListEventsTableViewCell.swift
//  Events
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
    func configure(event: Event) {
        self.nameEventsLabel.text = event.name?.capitalizingFirstLetter()
        if  event.numberOfDays == 1 {
            self.numbersDaysLabel.text = "\(event.numberOfDays) jour"
        } else {
            self.numbersDaysLabel.text = "\(event.numberOfDays) jours"
        }
//        self.numbersDaysLabel.text = "\(events.numberOfDays) jours"
        let frenchDateFormatter = DateFormatter()
        frenchDateFormatter.dateFormat = "dd-MM-yyyy"
        self.dateLabel.text = frenchDateFormatter.string(from: event.date)

//            self.dateLabel.text = date.string
        self.picture.image = UIImage(data: event.imageEvent)
    }
}
