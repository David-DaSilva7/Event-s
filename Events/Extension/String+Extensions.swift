//
//  String+Extension.swift
//  Events
//
//  Created by David Da Silva on 28/04/2022.
//

import Foundation

extension String {
    // Extension to capitalize the first letter of a word
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
