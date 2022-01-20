//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameEvents: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attendees = UserDefaults.standard.string(forKey: "attendees") ?? "Nom de l'evenement"
        nameEvents.text = attendees
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InfoEvents.numberDays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InfoEvents.numberDays[row]
    }

}
