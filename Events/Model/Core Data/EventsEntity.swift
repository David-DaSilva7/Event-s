//
//  EventsEntity.swift
//  Events
//
//  Created by David Da Silva on 23/02/2022.
//

import CoreData
@objc(Reminder)

public class EventsEntity: NSManagedObject {
    
    // Retrieve all recipes stored in Core Data
    static func all() -> [Event] {
        
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        guard let saveEvents = try? CoreDataStack.sharedInstance.viewContext.fetch(request) else {
            return []
        }
        var events = [Event]()
        for save in saveEvents {
            if let id = save.id,
               let imageEvent = save.imageEvent,
               let name = save.name,
               let date = save.date,
               let themes = save.themes,
               let days = save.days {
                
                let event = Event(
                    id: id,
                    name: name,
                    numberOfDays: Int16(save.numberOfDays),
                    attendees: save.attendees as! [String],
                    date: date,
                    days: days as! [Int : String],
                    themes: themes as! [String: String],
                    imageEvent: imageEvent)
                
                
                events.append(event)
                events.sort(by: {$0.date.compare($1.date) == .orderedAscending})
            }
        }
        return events
    }
    
    // Save recipe in Core Data
    static func save(_ event: Event) {
        let saveEvent = EventsEntity(context: CoreDataStack.sharedInstance.viewContext)
        saveEvent.id = event.id
        saveEvent.name = event.name
        saveEvent.numberOfDays = event.numberOfDays
        saveEvent.date = event.date 
        saveEvent.days = event.days as NSObject
        saveEvent.themes = event.themes as NSObject
        saveEvent.imageEvent = event.imageEvent
        saveEvent.attendees = event.attendees as NSObject
        saveContext()
    }
    
    // Check if data already exists in Core Data comparing url
    static func existBy(_ id: String) -> Bool {
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        guard let count = try? CoreDataStack.sharedInstance.viewContext.count(for: request) else {
            return false
        }
        return count > 0
    }
    
    // Delete RecipeEntity in Core Data. Use url in parameters to call the right data
    static func deleteBy(_ id: String) {
        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        if let saveEvents = try? CoreDataStack.sharedInstance.viewContext.fetch(request) {
            for event in saveEvents {
                CoreDataStack.sharedInstance.viewContext.delete(event)
            }
        }
        saveContext()
    }

    
    static func saveContext() {
        try? CoreDataStack.sharedInstance.viewContext.save()
    }
}

