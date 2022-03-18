//
//  EnterInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class EnterInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var event: Event?
    static var names: [String] = []
    
    @IBOutlet weak var nameEventsTextField: UITextField!
    @IBOutlet weak var nameAttendeesTextView: UITextView!
    @IBOutlet weak var nameNewAttendeesTextField: UITextField!
    @IBOutlet weak var numberDaysPickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addName: UIButton!
    @IBOutlet weak var clearAttendees: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBAction func unwindToEnterInfo(segue:UIStoryboardSegue) { }
    
    @IBAction func clearAttendees(_ sender: Any) {
        EnterInfoViewController.names.removeAll()
        nameAttendeesTextView.text.removeAll()
    }
    
    @IBAction func addNames(_ sender: Any) {
        if let namesAdd = nameNewAttendeesTextField.text, !namesAdd.isEmpty {
            EnterInfoViewController.names.append(namesAdd.capitalizingFirstLetter())
            nameNewAttendeesTextField.text?.removeAll()
            nameAttendeesTextView.text = self.get(EnterInfoViewController.names)
        }
    }
    
    @IBAction func goToAllInfo(_ sender: Any) {
//        nameEventsTextField.text = events?.nameEvents
//        nameEventsTextField.text = events?.nameEvents
//        if let events = events {
//            EventsEntity.addEventsToSave(events)
//        }
        event?.name = nameEventsTextField.text
        event?.attendees = EnterInfoViewController.names
        print("\(String(describing: event?.name))")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allInfoVCSegue" {
            if let allInfoVC = segue.destination as? AllInfoViewController {
                allInfoVC.event = event
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameEventsTextField.resignFirstResponder()
        nameNewAttendeesTextField.resignFirstResponder()
    }
    
    @IBAction func dateSelectedFromDatePicker(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: datePicker.date)
//        events?.date = date
        SettingsRepository.date = date

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func design() {
        addName.layer.cornerRadius = 9
        nameNewAttendeesTextField.layer.borderWidth = 0.5
        nameNewAttendeesTextField.layer.cornerRadius = 16
        nameNewAttendeesTextField.layer.borderColor = UIColor.black.cgColor
        nameEventsTextField.layer.borderWidth = 0.5
        nameEventsTextField.layer.cornerRadius = 16
        nameEventsTextField.layer.borderColor = UIColor.black.cgColor
        clearAttendees.layer.cornerRadius = 9
        buttonContinue.layer.cornerRadius = 16
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
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
        if InfoEvents.numberDaysArray[row] == 1 {
            return "\(InfoEvents.numberDaysArray[row]) jour"
        } else {
            return "\(InfoEvents.numberDaysArray[row]) jours"
        }
    }
    
    // Contenu de la ligne séléctionné 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = InfoEvents.numberDaysArray[row]
        let numberDays = selection
//        events?.numberDays = numberDays
//        SettingsRepository.numberDays = numberDays
        print ("--")
        print("ligne : ", row)
        print ("colonne : ", component)
        print ("Nombre de jour : ", selection)
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
