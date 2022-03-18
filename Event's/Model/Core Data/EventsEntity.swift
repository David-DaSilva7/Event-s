//
//  EventsEntity.swift
//  Event's
//
//  Created by David Da Silva on 23/02/2022.
//

import CoreData
@objc(Reminder)

class EventsEntity: NSManagedObject {
    
    // Retrieve all recipes stored in Core Data
    static func all() -> [Event] {
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        guard let saveEvents = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else {
            return []
        }
        var events = [Event]()
        for save in saveEvents {
            if let name = save.name,
               let date = save.date,
               let days = save.days {
                
                let event = Event(
                    name: name,
                    numberOfDays: Int16(save.numberOfDays),
                    attendees: save.attendees as! [String],
                    date: date,
//                    image: save.image,
                    days: days as! [Int : String])
                events.append(event)
            }
        }
        return events
    }
    
    // Save recipe in Core Data
    static func addEventsToSave(_ event: Event) {
        let saveEvent = EventsEntity(context: CoreDataStack.sharedInstance.viewContext)
        saveEvent.name = event.name
        saveEvent.numberOfDays = event.numberOfDays!
        saveEvent.date = event.date
        saveEvent.days = event.days as NSObject
//        saveEvent.image = event.image
        saveEvent.attendees = event.attendees as NSObject
        saveContext()
    }
    
    // Check if data already exists in Core Data comparing url
    static func existBy(_ url: String) -> Bool {
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "image_url == %@", url)
        guard let count = try? CoreDataStack.sharedInstance.viewContext.count(for: request) else {
            return false
        }
        return count > 0
    }
    
    static func saveContext() {
        try? CoreDataStack.sharedInstance.viewContext.save()
    }
}

