//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate, YourCellDelegate {
    
    
    // MARK: - Properties
    private let segueIdentifier = "segueToPersonInfo"
    private var selectedName = ""
    static var event: Event?
    
    // MARK: - Outlets
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var nameEventsLabel: UILabel!
    @IBOutlet weak var imageEvents: UIImageView!
    @IBOutlet weak var numberDaysLabel: UILabel!
    @IBOutlet weak var dayOrganizationTextView: UITextView!
    @IBOutlet weak var attendeesTableView: UITableView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonAddAttendees: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var nameNewAttendees: UITextField!
    @IBOutlet weak var daysPickerView: UIPickerView!
    
    // MARK: - Actions
    @IBAction func buttonContinue(_ sender: Any) {
        if let id = AllInfoViewController.event?.id, let event = AllInfoViewController.event {
            if EventsEntity.existBy(id) {
                EventsEntity.deleteBy(id)
            }
            EventsEntity.save(event)
        }
    }
    
    @IBAction func buttonLibrary(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        present(image, animated: true)
    }
    
    @IBAction func buttonAddAttendees(_ sender: Any) {
        if let namesAdd = nameNewAttendees.text, !namesAdd.isEmpty {
            AllInfoViewController.event?.attendees.append(namesAdd.capitalizingFirstLetter())
            nameNewAttendees.text?.removeAll()
            attendeesTableView.reloadData()
        }
    }
    
    @IBAction func dismissKeyborad(_ sender: UITapGestureRecognizer) {
        dayOrganizationTextView.resignFirstResponder()
        nameNewAttendees.resignFirstResponder()
    }
    
    // MARK: - Functions
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.attendeesTableView.reloadData()
        print("\(String(describing: AllInfoViewController.event?.name))")
        design()
        if let event = AllInfoViewController.event {
            nameEventsLabel.text = event.name?.capitalizingFirstLetter()
            if event.numberOfDays == 1 {
                numberDaysLabel.text = "\(event.numberOfDays) jour"
            } else {
                numberDaysLabel.text = "\(event.numberOfDays) jours"
            }
            date.text = event.date
        }
    }
    
//     var titleNav: UILabel = {
//     let string = UILabel()
//     string.font = UIFont(name: "gungsuh", size: 21.0)
//     return string
//    }()
//
//     func setTitleNav() {
//     let message = "Event's"
//
//     let attributedString = NSMutableAttributedString(string: message)
//        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 211/255, green: 45/255, blue: 39/255, alpha: 1)]
//     let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
//
//     attributedString.addAttributes(firstAttributes, range: NSRange(location: 0, length: 1))
//
//      attributedString.addAttributes(secondAttributes, range: NSRange(location: 1, length: 6))
//
//      titleNav.attributedText = attributedString
//        }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        ListEventsViewController.setTitleNav()
        navigationController?.navigationBar.topItem?.titleView = ListEventsViewController.titleNav
        imageEvents.image = UIImage(data: AllInfoViewController.event!.imageEvent)
        daysPickerView.delegate = self
        daysPickerView.dataSource = self
    }
    
    // Notifies the view controller that a segue is about to be performed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let personInfoVC = segue.destination as! PersonInfoViewController
            personInfoVC.nameAttendee = selectedName
//savedEvent
        }
    }
    
    // Function to know on which particpants we pressed
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        if let event = AllInfoViewController.event {
            selectedName = "\(event.attendees[tag])"
        }
    }
    
    // Clear the keyboard when you press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Design of the different elements
    private func design() {
        addPictureButton.layer.cornerRadius = 17
        buttonAddAttendees.layer.cornerRadius = 9
        buttonContinue.layer.cornerRadius = 16
        dayOrganizationTextView.layer.borderColor = UIColor.black.cgColor
        dayOrganizationTextView.layer.borderWidth = 0.5
        dayOrganizationTextView.layer.cornerRadius = 16
    }
        
    // MARK: - PickerView DataSource and Delegate
    
    // Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(AllInfoViewController.event?.numberOfDays ?? 1 )
    }
    
    // Content in each line
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Jour \(InfoEvents.numberDaysArray[row])"
    }
    
    // Content of the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = InfoEvents.numberDaysArray[row]
//                if let event = event {
//                    let days = event.days
//                    let key = Array(days.keys)[row]
//                    let value = Array(days.values)[row]
//                    InfoEvents.numberDaysArray[row] = key
//                    dayOrganizationTextView.text = value
//
//                }
//        if InfoEvents.numberDaysArray[row] == 1 {
//            dayOrganizationTextView.text = "xoanoxnoao"
//        } else {
//            dayOrganizationTextView.text = "haoioisa"
//        }
        if row == 0 {
//            if ((event?.days[selection]?.isEmpty) != nil) {
//                dayOrganizationTextView.text = ""
//            } else {
//                event?.days[selection] = dayOrganizationTextView.text
//            }
            AllInfoViewController.event?.days[0] = dayOrganizationTextView.text
        } else if row == 1 {
            AllInfoViewController.event?.days[1] = dayOrganizationTextView.text
        }
//        event?.days[selection] = dayOrganizationTextView.text
//        dayOrganizationTextView.text = event?.days[InfoEvents.numberDaysArray[row]]
        print(AllInfoViewController.event?.days ?? [:])
    }
}

// MARK: - TableView DataSource extension
extension AllInfoViewController: UITableViewDataSource {
    
    // Cell numbers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllInfoViewController.event?.attendees.count ?? 0
    }
    
    // Content in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeesCell",
                                                       for: indexPath) as? AttendeesTableViewCell else {
            return UITableViewCell()
        }
        cell.cellDelegate = self
        cell.configure(name: AllInfoViewController.event?.attendees[indexPath.row] ?? "")
        cell.namesAttendees.tag = indexPath.row
        return cell
    }
}

// MARK: - TableView Delegate extension
extension AllInfoViewController: UITableViewDelegate {
    
    // Action when you press on a cell
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        selectedName = event?.attendees[indexPath.row] ?? ""
    //        performSegue(withIdentifier: segueIdentifier, sender: self)
    //    }
    
    // Action when we delete on a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllInfoViewController.event?.attendees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Recover library image extension
extension AllInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // Recover image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageEvents.image = image
            AllInfoViewController.event?.imageEvent = image.pngData()!
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Dismiss Picker 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
