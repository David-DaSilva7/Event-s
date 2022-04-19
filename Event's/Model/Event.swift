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
    var id: String = UUID().uuidString
    var name: String?
    var numberOfDays: Int16 
    var attendees: [String]  = []
    var date: String?
    var days: [Int: String]
    var themes: [String: String]
//    var imageEvent: String?
}
