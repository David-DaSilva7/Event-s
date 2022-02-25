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
    static func all() -> [Events] {
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        guard let saveEvents = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else {
            return []
        }
        var events = [Events]()
        for save in saveEvents {
            if let name = save.nameEvents,
               let numberDays = save.numberDays,
               let date = save.date {
                let event = Events(
                    date: date,
                    numberDays: numberDays,
                    nameEvents: name)
                events.append(event)
            }
        }
        return events
    }
    
    // Save recipe in Core Data
    static func addEventsToSave(_ event: Events) {
        let saveEvent = EventsEntity(context: CoreDataStack.sharedInstance.viewContext)
        saveEvent.nameEvents = event.nameEvents
        saveEvent.numberDays = event.numberDays
        saveEvent.date = event.date
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

