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
            if let id = save.id,
               let imageEvent = save.imageEvent,
               let name = save.name,
               let date = save.date,
               let themes = save.themes,
               let days = save.days {
                
                let event = Event(
                    id: id,
                    name: name,
//                    imageEvent: imageEvent as! String,
                    numberOfDays: Int16(save.numberOfDays),
                    attendees: save.attendees as! [String],
                    date: date,
                    days: days as! [Int : String],
                    themes: themes as! [String: String])
                
                events.append(event)
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
        saveEvent.date = event.date as NSObject? as? String
        saveEvent.days = event.days as NSObject
        saveEvent.themes = event.themes as NSObject
        saveEvent.imageEvent = event.imageEvent as NSObject? as? Data
        saveEvent.attendees = event.attendees as NSObject
        saveContext()
    }
    
//    static func add(_ themes: [String: String], in eventWithUUID: String) { // mettre  à jour l'event déjà existant en y ajoutant les themes
//        // TODO: Récuperer l'event via l'uuid de l'event
//        let saveThemes = EventsEntity(context: CoreDataStack.sharedInstance.viewContext)
//        let request: NSFetchRequest<EventsEntity> = EventsEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", eventWithUUID)
//        do
//        {
//            let object = try CoreDataStack.sharedInstance.viewContext.fetch(request)
//            if object.count == 1
//            {
//                let objectUpdate = object.first!
//                objectUpdate.setValue(themes, forKey: "themes")
//                do {
//                    saveThemes.themes = themes as NSObject
//                    saveContext()
//                }
//            }
//        }
//        catch
//        {
//            print(error)
//        }
//
//        // trasnformer le resultat de la requete en event
//        // event.themes = themes
//         // rechercher update object in core data
//    }
    
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

