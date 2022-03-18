//
//  ListEventsViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit
import CoreData

class ListEventsViewController: UIViewController {
    
    private var events = EventsEntity.all()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    private func prepareView() {
        events = EventsEntity.all()
        tableView.reloadData()
    }
}

    // MARK: - TableView DataSource extension
    extension ListEventsViewController: UITableViewDataSource {
        
        //        Nombres de sections
        func numberOfSections(in tableView : UITableView) -> Int {
            return 1
        }
        
        //        Nombres de cellules
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
        }
        
        //    Contenu dans la cellule
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
        // Lorsqu'on appui sur une cellue
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
            }
        }
    }

