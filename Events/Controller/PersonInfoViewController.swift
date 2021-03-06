//
//  PersonInfoViewController.swift
//  Events
//
//  Created by David Da Silva on 11/02/2022.
//

import UIKit

class PersonInfoViewController: UIViewController {
    
    // MARK: - Properties
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
        print(AllInfoViewController.event?.themes ?? [:])
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
            changeDescriptionThemeVC.themeName = selectedNameTheme
        }
    }
    
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
        return AllInfoViewController.event?.themes.count ?? 0
    }
    
    // Content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NamesThemesCell",
                                                       for: indexPath) as? NamesThemesTableViewCell else { return UITableViewCell()
        }
        if let event = AllInfoViewController.event {
            let themes = event.themes
            let key = Array(themes.keys)[indexPath.row]
            cell.configure(nameTheme: "\(key)" )
        }
        
        return cell
    }
}

// MARK: - TableView Delegate extension
extension PersonInfoViewController: UITableViewDelegate {
    // Design of the different elements// Action when you press on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if AllInfoViewController.event != nil {
            let key = Array(AllInfoViewController.event!.themes.keys)[indexPath.row]
            selectedNameTheme = "\(key)"
        }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Action when we delete on a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if AllInfoViewController.event != nil {
                let key = Array(AllInfoViewController.event!.themes.keys)[indexPath.row]
                AllInfoViewController.event?.themes.removeValue(forKey: "\(key)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
