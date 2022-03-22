//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, YourCellDelegate {
    
    
    
    private let segueIdentifier = "segueToPersonInfo"
    var selectedName = ""
    var events = EventsEntity.all()
    var event: Event?
    
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var nameEventsLabel: UILabel!
    @IBOutlet weak var imageEvents: UIImageView!
    @IBOutlet weak var numberDaysLabel: UILabel!
    @IBOutlet weak var dayOrganizationTextView: UITextView!
    @IBOutlet weak var attendeesTableView: UITableView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonAddAttendees: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    
    
    @IBAction func buttonContinue(_ sender: Any) {
        
        print("Bouton appuyé")
    }
    
    @IBAction func buttonLibrary(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        present(image, animated: true)
        {
            
        }
    }
    
    @IBAction func dismissKeyborad(_ sender: UITapGestureRecognizer) {
        dayOrganizationTextView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        if let event = event {
            nameEventsLabel.text = event.name
            if event.numberOfDays == 1 {
                numberDaysLabel.text = "\(event.numberOfDays) jour"
            } else {
                numberDaysLabel.text = "\(event.numberOfDays) jours"
            }
            date.text = event.date
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(String(describing: event?.name))")
        //        events = EventsEntity.all()
        //        attendeesTableView.reloadData()
        //        var event = Events(date: date.text ?? "", numberDays: numberDaysLabel.text ?? "", nameEvents: nameEventsLabel.text ?? "")
        
        
        
    }
    
    func didPressButton(_ tag: Int) {
         print("I have pressed a button with a tag: \(tag)")
        selectedName = "\(String(describing: event?.attendees[tag]))"
        print("\(String(describing: event?.attendees[tag]))")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let personInfoVC = segue.destination as! PersonInfoViewController
            personInfoVC.nameAttendee = selectedName
            personInfoVC.event = event
        }
    }
    
    func design() {
        addPictureButton.layer.cornerRadius = 17
        buttonAddAttendees.layer.cornerRadius = 9
        buttonContinue.layer.cornerRadius = 16
        dayOrganizationTextView.layer.borderColor = UIColor.black.cgColor
        dayOrganizationTextView.layer.borderWidth = 0.5
        dayOrganizationTextView.layer.cornerRadius = 16
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(event?.numberOfDays ?? 1 - 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "Jour \(InfoEvents.numberDaysArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = InfoEvents.numberDaysArray[row]
        print ("--")
        print("ligne : ", row)
        print ("colonne : ", component)
        print ("Nombre de jour : ", selection)
        
        //        if row == 0 {
        //            dayOrganizationTextView.text = "Acrobranche"
        //        }else if row == 1 {
        //            dayOrganizationTextView.text = "Piscine"
        //        }
    }
}

// MARK: - TableView DataSource extension
extension AllInfoViewController: UITableViewDataSource {
    
    //        Nombres de sections
    func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }
    
    //        Nombres de cellules
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event?.attendees.count ?? 0
    }
    
    //    Contenu dans la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeesCell",
                                                       for: indexPath) as? AttendeesTableViewCell else {
            return UITableViewCell()
        }
        cell.cellDelegate = self
        cell.configure(name: event?.attendees[indexPath.row] ?? "")
        cell.namesAttendees.tag = indexPath.row
        
        
        
        return cell
    }
}
// MARK: - TableView Delegate extension
extension AllInfoViewController: UITableViewDelegate {
    // Lorsqu'on appui sur une cellue
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedName = event?.attendees[indexPath.row] ?? ""
//        performSegue(withIdentifier: segueIdentifier, sender: self)
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            event?.attendees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension AllInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                    imageEvents.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
