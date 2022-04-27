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
    
    static var titleNav: UILabel = {
        let string = UILabel()
        string.font = UIFont(name: "gungsuh", size: 21.0)
        return string
    }()
    
    static func setTitleNav() {
        let message = "Event's"
        
        let attributedString = NSMutableAttributedString(string: message)
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 211/255, green: 45/255, blue: 39/255, alpha: 1)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        
        attributedString.addAttributes(firstAttributes, range: NSRange(location: 0, length: 1))
        
        attributedString.addAttributes(secondAttributes, range: NSRange(location: 1, length: 6))
        
        titleNav.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListEventsViewController.setTitleNav()
        navigationController?.navigationBar.topItem?.titleView = ListEventsViewController.titleNav
    }
    
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            AllInfoViewController.event = selectedEvent
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
}

