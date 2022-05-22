//
//  ListEventsViewController.swift
//  Events
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit
import CoreData

class ListEventsViewController: UIViewController {
    
    // MARK: - Properties
    private var events: [Event] = []
    private var futurEvents: [Event] = []
    private var selectedEvent: Event?
    private let segueIdentifier = "segueToAllInfo"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @IBAction func unwindToListEvent(segue:UIStoryboardSegue) { }
    
    // MARK: - Functions
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    // Function that prepares the view
    private func prepareView() {
        events = EventsEntity.all()
        futurEvents = events.filter { event in
            let expireDate = Calendar.current.date(byAdding: .day,
                                                   value: Int(event.numberOfDays + 1),
                                                   to: event.date)
            return Date() <= expireDate ?? Date()
        }
        tableView.reloadData()
    }
    
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            AllInfoViewController.event = selectedEvent
        }
    }
    

}

// MARK: - TableView DataSource extension
extension ListEventsViewController: UITableViewDataSource {
    
    // Cell numbers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futurEvents.count
    }
    
    // Content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListEventsCell",
                                                       for: indexPath) as? ListEventsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(event: futurEvents[indexPath.row])
        return cell
    }
}
// MARK: - TableView Delegate extension
extension ListEventsViewController: UITableViewDelegate {
    
    // Action when you press on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = futurEvents[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Action when we delete on a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EventsEntity.deleteBy(futurEvents[indexPath.row].id)
            prepareView()
        }
    }
    
    // Cell height 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
}

