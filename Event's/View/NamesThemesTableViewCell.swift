//
//  NamesThemesTableViewCell.swift
//  Event's
//
//  Created by David Da Silva on 04/02/2022.
//

import UIKit

class NamesThemesTableViewCell: UITableViewCell {

    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var viewTheme: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewTheme.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(nameTheme: String) {
        themeName.text = nameTheme
    }

}
