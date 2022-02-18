//
//  AddThemesViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AddThemesViewController: UIViewController {
    
    static var themes: [String] = []
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameThemeTextField: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameThemeTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let nameTheme = nameThemeTextField.text, !nameTheme.isEmpty {
            AddThemesViewController.themes.append(nameTheme)
            let nameTheme = AddThemesViewController.themes
        SettingsRepository.nameTheme = nameTheme
            print("\(AddThemesViewController.themes)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
}
