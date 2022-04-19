//
//  EnterInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class EnterInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Properties
    private var event = Event(name: "", numberOfDays: 1, attendees: [], date: "", days: [:], themes: [:])
    private var names: [String] = []
    
    // MARK: - Outlets
    @IBOutlet weak var nameEventsTextField: UITextField!
    @IBOutlet weak var nameAttendeesTextView: UITextView!
    @IBOutlet weak var nameNewAttendeesTextField: UITextField!
    @IBOutlet weak var numberDaysPickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addName: UIButton!
    @IBOutlet weak var clearAttendees: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    
    // MARK: - Actions
    @IBAction func clearAttendees(_ sender: Any) {
        names.removeAll()
        nameAttendeesTextView.text.removeAll()
    }
    
    @IBAction func addNames(_ sender: Any) {
        if let namesAdd = nameNewAttendeesTextField.text, !namesAdd.isEmpty {
            names.append(namesAdd.capitalizingFirstLetter())
            nameNewAttendeesTextField.text?.removeAll()
            nameAttendeesTextView.text = self.get(names)
        }
    }
    
    @IBAction func goToAllInfo(_ sender: Any) {
        event.name = nameEventsTextField.text
        event.attendees = names
    }
    
    @IBAction func dateSelectedFromDatePicker(_ sender: Any) {
        dateSelected()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameEventsTextField.resignFirstResponder()
        nameNewAttendeesTextField.resignFirstResponder()
    }
    
    // MARK: - Functions
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allInfoVCSegue" {
            if let allInfoVC = segue.destination as? AllInfoViewController {
                allInfoVC.event = event
            }
        }
    }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        dateToday()
    }
    
    // Retrieve the date selected on the date picker
    private func dateSelected() {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.day = -0
        components.calendar = calendar
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: datePicker.date)
        self.datePicker.minimumDate = minDate;
        event.date = date
    }
    
    // Retrieve the date today
    private func dateToday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        event.date = formattedDate
    }
    
    // Clear the keyboard when you press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // List of participants
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
    
    // Design of the different elements
    private func design() {
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
    
    // MARK: - PickerView DataSource and Delegate
    // Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InfoEvents.numberDaysArray.count
    }
    
    // Content in each line
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if InfoEvents.numberDaysArray[row] == 1 {
            return "\(InfoEvents.numberDaysArray[row]) jour"
        } else {
            return "\(InfoEvents.numberDaysArray[row]) jours"
        }
    }
    
    // Content of the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = InfoEvents.numberDaysArray[row]
        event.numberOfDays = Int16(selection)
    }
}
