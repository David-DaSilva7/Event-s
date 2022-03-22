//
//  Event.swift
//  Event's
//
//  Created by David Da Silva on 23/02/2022.
//

import Foundation
import UIKit

// MARK: - Structure
struct Event {
    var name: String?
    var numberOfDays: Int16 = 1
    var attendees: [String]  = []
    var date: String?
//    var image: UIImage
    var days: [Int: String]
    var themes: [String]
}
