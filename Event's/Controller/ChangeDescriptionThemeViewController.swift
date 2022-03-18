//
//  ChangeDescriptionThemeViewController.swift
//  Event's
//
//  Created by David Da Silva on 17/02/2022.
//

import UIKit

class ChangeDescriptionThemeViewController: UIViewController {

    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var nameTheme: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
    
    var themeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTheme.text = themeName
        design()
    }
    
    func design() {
        viewName.layer.cornerRadius = 16
        registerButton.layer.cornerRadius = 16
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 16
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        descriptionTextView.resignFirstResponder()
    }
}
