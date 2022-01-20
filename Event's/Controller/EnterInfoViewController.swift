//
//  EnterInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class EnterInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var names: [String] = []
    
    @IBOutlet weak var nameEvents: UITextField!
    @IBOutlet weak var nameAttendees: UITextView!
    @IBOutlet weak var nameNewAttendees: UITextField!
    
    @IBAction func addNames(_ sender: Any) {
        if let namesAdd = nameNewAttendees.text, !namesAdd.isEmpty {
            names.append(namesAdd.capitalizingFirstLetter())
            nameNewAttendees.text?.removeAll()
            nameAttendees.text = self.get(self.names)
        }
    }
    
    
    @IBAction func goToAllInfo(_ sender: Any) {
        var attendees = nameEvents.text
        UserDefaults.standard.set(attendees, forKey: "attendees")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
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

private func get(_ names: [String]) -> String {
    var namesList = ""
    for (index, name) in names.enumerated() {
        if index == 0 {
            namesList += "- \(name)"
        } else {
            namesList += "\n- \(name)"
        }
    }
    
    return namesList
}
    
}
