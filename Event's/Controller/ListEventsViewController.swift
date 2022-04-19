//
//  ListEventsViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit
import CoreData

class ListEventsViewController: UIViewController {
    
    // MARK: - Properties
    private var events = EventsEntity.all()
    private var selectedEvent: Event?
    private let segueIdentifier = "segueToAllInfo"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @IBAction func unwindToListEvents(segue:UIStoryboardSegue) { }
    
    // MARK: - Functions
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let allInfoVC = segue.destination as! AllInfoViewController
            allInfoVC.event = selectedEvent
        }
    }
    
    // Function that prepares the view
    private func prepareView() {
        events = EventsEntity.all()
        tableView.reloadData()
    }
    
}

// MARK: - TableView DataSource extension
extension ListEventsViewController: UITableViewDataSource {
    
    // Cell numbers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListEventsCell",
                                                       for: indexPath) as? ListEventsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(events: events[indexPath.row])
        return cell
    }
}
// MARK: - TableView Delegate extension
extension ListEventsViewController: UITableViewDelegate {
    
    // Action when you press on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = events[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Action when we delete on a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("current event id: \(events[indexPath.row].id)")
            EventsEntity.deleteBy(events[indexPath.row].id)
            events = EventsEntity.all()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

