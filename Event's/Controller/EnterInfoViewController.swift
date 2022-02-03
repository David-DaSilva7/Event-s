//
//  EnterInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class EnterInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var names: [String] = []
    
    @IBOutlet weak var nameEventsTextField: UITextField!
    @IBOutlet weak var nameAttendeesTextView: UITextView!
    @IBOutlet weak var nameNewAttendeesTextField: UITextField!
    @IBOutlet weak var numberDaysPickerView: UIPickerView!
    
    @IBAction func unwindToEnterInfo(segue:UIStoryboardSegue) { }
    
    @IBAction func addNames(_ sender: Any) {
        if let namesAdd = nameNewAttendeesTextField.text, !namesAdd.isEmpty {
            names.append(namesAdd.capitalizingFirstLetter())
            nameNewAttendeesTextField.text?.removeAll()
            nameAttendeesTextView.text = self.get(self.names)
        }
    }
    
    
    @IBAction func goToAllInfo(_ sender: Any) {
        let nameEvents = nameEventsTextField.text
        SettingsRepository.nameEvents = nameEvents ?? ""
        
        let nameAttendees = names
        SettingsRepository.attendees = nameAttendees 
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameEventsTextField.resignFirstResponder()
        nameNewAttendeesTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func removeName(indexName: Int) {
        names.remove(at: indexName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // nombres de colonnes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //nombres de ligne
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InfoEvents.numberDaysArray.count
    }
    
    // Contenu dans les lignes
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InfoEvents.numberDaysArray[row]
    }
    
    // Contenu de la ligne séléctionné 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = InfoEvents.numberDaysArray[row]
        print ("--")
        print("ligne : ", row)
        print ("colonne : ", component)
        print ("Nombre de jour : ", selection)
        
        let numberDays = selection
        SettingsRepository.numberDays = numberDays 
        
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
    
//        func retrieveNumberDays() {
//            let numberDaysIndex = numberDaysPickerView.selectedRow(inComponent: 0)
//            let numberDays = InfoEvents.numberDaysArray[numberDaysIndex]
//            let infoEvents = InfoEvents(numberDays: numberDays)
//        }
}
