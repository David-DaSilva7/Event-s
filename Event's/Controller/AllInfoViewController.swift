//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
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
        nameEventsLabel.text = event?.name
        if SettingsRepository.numberDays == "1"{
            numberDaysLabel.text = "\(SettingsRepository.numberDays) jour"
        } else {
            numberDaysLabel.text = "\(SettingsRepository.numberDays) jours"
        }
        date.text = SettingsRepository.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(String(describing: event?.name))")
        //        events = EventsEntity.all()
        //        attendeesTableView.reloadData()
        //        var event = Events(date: date.text ?? "", numberDays: numberDaysLabel.text ?? "", nameEvents: nameEventsLabel.text ?? "")
        
        
        
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
//        return InfoEvents.numberDaysArray.firstIndex(of: SettingsRepository.numberDays)! + 1
        return 5
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let personInfoVC = segue.destination as! PersonInfoViewController
            personInfoVC.nameAttendee = selectedName
        }
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
        return SettingsRepository.attendees.count
    }
    
    //    Contenu dans la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeesCell",
                                                       for: indexPath) as? AttendeesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: SettingsRepository.attendees[indexPath.row])
        
        return cell
    }
}
// MARK: - TableView Delegate extension
extension AllInfoViewController: UITableViewDelegate {
    // Lorsqu'on appui sur une cellue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = SettingsRepository.attendees[indexPath.row]
        //        let nameAttendee = SettingsRepository.attendees[indexPath.row]
        //        SettingsRepository.attendee = nameAttendee
        print("J'AI APPUYÉ")
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            SettingsRepository.removeName(at: indexPath.row)
            //            enterInfoViewController.names.remove(at: indexPath.row)
            //            enterInfoViewController.removeName(indexName: indexPath.row)
            SettingsRepository.attendees.remove(at: indexPath.row)
            //            EnterInfoViewController.names.remove(at: indexPath.row)
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
