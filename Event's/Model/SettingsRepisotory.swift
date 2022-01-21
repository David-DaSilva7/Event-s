//
//  SettingsRepisotory.swift
//  Event's
//
//  Created by David Da Silva on 21/01/2022.
//

import Foundation

class SettingsRepository {
    
    private enum Keys {
       static let attendees = "attendees"
    }
    
    static var attendees: String {
       get {
          return UserDefaults.standard.string(forKey: Keys.attendees) ?? "Nom de l'evenement"
       }
       set {
          UserDefaults.standard.set(newValue, forKey: Keys.attendees)
       }
    }

}
