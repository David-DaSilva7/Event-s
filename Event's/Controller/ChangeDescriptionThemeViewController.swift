//
//  ChangeDescriptionThemeViewController.swift
//  Event's
//
//  Created by David Da Silva on 17/02/2022.
//

import UIKit

class ChangeDescriptionThemeViewController: UIViewController {
    
    // MARK: - Properties
    var event: Event?
    private var themes: [String: String] = [:]
    var themeName = ""
    weak var delegate: ThemeEnteredDelegate? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var nameTheme: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Actions
    @IBAction func registerButton(_ sender: Any) {
        event?.themes[themeName] = descriptionTextView.text
        print(event?.themes ?? [:])
        delegate?.userDidEnteredTheme(keyTheme: themeName, valueTheme: descriptionTextView.text)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        descriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Functions
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTheme.text = themeName
        descriptionTextView.text = event?.themes[themeName]
    }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }
    
    // Design of the different elements
    private func design() {
        viewName.layer.cornerRadius = 16
        registerButton.layer.cornerRadius = 16
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 16
    }
    
    
}

