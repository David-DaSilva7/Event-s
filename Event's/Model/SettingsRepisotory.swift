//
//  SettingsRepisotory.swift
//  Event's
//
//  Created by David Da Silva on 21/01/2022.
//

import Foundation

class SettingsRepository {

    private enum Keys {
        static let nameEvents = "nameEvents"
        static let numberDays = "numberDays"
        static let attendees = "attendees"
        static let attendee = "attendee"
        static let date = "date"
        static let nameTheme = "nameTheme"
    }
    
    static var nameEvents: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.nameEvents) ?? "Nom de l'evenement"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.nameEvents)
        }
    }
    
    static var numberDays: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.numberDays) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.numberDays)
        }
    }
    
    static var attendees: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.attendees) as! [String]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.attendees)
        }
    }
    
//    static var attendee: String {
//        get {
//            return UserDefaults.standard.string(forKey: Keys.attendee) ?? ""
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.attendee)
//        }
//    }
    
    static var date: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.date) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.date)
        }
    }
    
    static var nameTheme: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.nameTheme) as! [String]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.nameTheme)
        }
    }
}
