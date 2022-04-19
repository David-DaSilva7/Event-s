//
//  AddThemesViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AddThemesViewController: UIViewController {
    
    // MARK: - Properties
    var event: Event?
    private var themes: [String: String] = [:]
    weak var delegate: ThemeEnteredDelegate? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameThemeTextField: UITextField!
    @IBOutlet weak var register: UIButton!
    
    // MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameThemeTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if var event = event {
            //            EventsEntity.add(event.themes, in: event.id)
            if let nameTheme = nameThemeTextField.text, !nameTheme.isEmpty {
                themes = [nameTheme: descriptionTextView.text]
                event.themes = themes
                print(event.themes )
                delegate?.userDidEnteredTheme(keyTheme: nameTheme, valueTheme: descriptionTextView.text)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    // Design of the different elements
    private func design() {
        nameThemeTextField.layer.borderWidth = 0.5
        nameThemeTextField.layer.borderColor = UIColor.black.cgColor
        nameThemeTextField.layer.cornerRadius = 16
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 16
        register.layer.cornerRadius = 16
    }
}

// MARK: - Protocols
protocol ThemeEnteredDelegate: AnyObject {
    // Protocol to adjust the table view with the new theme
    func userDidEnteredTheme(keyTheme: String, valueTheme: String)
}
