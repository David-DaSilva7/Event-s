//
//  PersonInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 11/02/2022.
//

import UIKit

class PersonInfoViewController: UIViewController {
    
    private let segueIdentifier = "segueToChangeDescriptionTheme"
    private var selectedNameTheme = ""
    
    var nameAttendee = ""
    
    @IBAction func unwindPersonInfo(segue:UIStoryboardSegue) { }
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addTheme: UIButton!
    @IBOutlet weak var themesTableView: UITableView!
    
    @IBAction func unwindToEnterInfo(segue:UIStoryboardSegue) { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        themesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
//        nameLabel.text = SettingsRepository.attendee
        nameLabel.text = nameAttendee
        // Do any additional setup after loading the view.
    }
    
    func design(){
        addTheme.layer.cornerRadius = 9
        viewName.layer.cornerRadius = 16
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let changeDescriptionThemeVC = segue.destination as! ChangeDescriptionThemeViewController
            changeDescriptionThemeVC.themeName = selectedNameTheme
        }
    }
}

// MARK: - TableView DataSource extension
extension PersonInfoViewController: UITableViewDataSource {
    //
    //    //        Nombres de sections
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }
    
    //        Nombres de cellules
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return SettingsRepository.nameTheme.count
      
    }
    
    //    Contenu dans la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NamesThemesCell",
                                                       for: indexPath) as? NamesThemesTableViewCell else { return UITableViewCell()
        }
        cell.configure(nameTheme: SettingsRepository.nameTheme[indexPath.row].capitalizingFirstLetter())
        
        return cell
    }
}
    // MARK: - TableView Delegate extension
    extension PersonInfoViewController: UITableViewDelegate {
    //     Lorsqu'on appui sur une cellue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                selectedNameTheme = SettingsRepository.nameTheme[indexPath.row].capitalizingFirstLetter()
                performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            SettingsRepository.removeName(at: indexPath.row)
            //            enterInfoViewController.names.remove(at: indexPath.row)
            //            enterInfoViewController.removeName(indexName: indexPath.row)
            //            SettingsRepository.attendees.remove(at: indexPath.row)
            //            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
