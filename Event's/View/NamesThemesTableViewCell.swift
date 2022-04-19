//
//  NamesThemesTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 04/02/2022.
//

import UIKit

class NamesThemesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var viewTheme: UIView!
    
    // MARK: - Functions
    // Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTheme.layer.cornerRadius = 16
    }
    
    // Configure the different elements of the cell
    func configure(nameTheme: String) {
        themeName.text = nameTheme
    }
}
