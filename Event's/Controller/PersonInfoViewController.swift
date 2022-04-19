//
//  PersonInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 11/02/2022.
//

import UIKit

class PersonInfoViewController: UIViewController {
    
    // MARK: - Properties
    //    private var events = EventsEntity.all()
    var event: Event?
    private let segueIdentifier = "segueToChangeDescriptionTheme"
    private let segueIdentifier2 = "segueToAddThemes"
    private var selectedNameTheme = ""
    var nameAttendee = ""
    
    // MARK: - Outlets
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addTheme: UIButton!
    @IBOutlet weak var themesTableView: UITableView!
    
    // MARK: - Actions
    @IBAction func unwindToPersonInfo(segue:UIStoryboardSegue) { }
    
    // MARK: - Functions
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        themesTableView.reloadData()
        //        prepareView()
    }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        nameLabel.text = nameAttendee
    }
    
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let changeDescriptionThemeVC = segue.destination as! ChangeDescriptionThemeViewController
            changeDescriptionThemeVC.event = event
            changeDescriptionThemeVC.themeName = selectedNameTheme
            changeDescriptionThemeVC.delegate = self
        } else if segue.identifier == segueIdentifier2 {
            let addThemesVC = segue.destination as! AddThemesViewController
            addThemesVC.event = event
            addThemesVC.delegate = self
        }
    }
    
    //    private func prepareView() {
    //        events = EventsEntity.all()
    //    }
    
    // Design of the different elements
    func design(){
        addTheme.layer.cornerRadius = 9
        viewName.layer.cornerRadius = 16
    }
}

// MARK: - TableView DataSource extension
extension PersonInfoViewController: UITableViewDataSource {
    
    // Cell numbers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event?.themes.count ?? 0
    }
    
    // Content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NamesThemesCell",
                                                       for: indexPath) as? NamesThemesTableViewCell else { return UITableViewCell()
        }
        if let event = event {
            let themes = event.themes
            let key   = Array(themes.keys)[indexPath.row]
            cell.configure(nameTheme: "\(key)" )
        }
        
        return cell
    }
}

// MARK: - TableView Delegate extension
extension PersonInfoViewController: UITableViewDelegate {
    // Design of the different elements// Action when you press on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = event {
            let themes = event.themes
            let key = Array(themes.keys)[indexPath.row]
            //            let value = Array(themes.values)[indexPath.row]
            selectedNameTheme = "\(key)"
            //            selectedDescriptionTheme = "\(value)"
            
        }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Action when we delete on a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            SettingsRepository.removeName(at: indexPath.row)
            //            enterInfoViewController.names.remove(at: indexPath.row)
            //            enterInfoViewController.removeName(indexName: indexPath.row)
            //            SettingsRepository.attendees.remove(at: indexPath.row)
            if editingStyle == .delete {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        }
    }
}

// MARK: - Change Themes on the TableView extension
// To retain changes in a theme
extension PersonInfoViewController: ThemeEnteredDelegate {
    func userDidEnteredTheme(keyTheme: String, valueTheme: String) {
        event?.themes.updateValue(valueTheme, forKey: keyTheme)
    }
}
