//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    private let segueIdentifier = "segueToPersonInfo"
    
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var nameEventsLabel: UILabel!
    @IBOutlet weak var imageEvents: UIImageView!
    @IBOutlet weak var numberDaysLabel: UILabel!
    @IBOutlet weak var dayOrganizationTextView: UITextView!
    @IBOutlet weak var attendeesTableView: UITableView!
    
    
    @IBAction func buttonLibrary(_ sender: UIButton) {
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            
        }
    }
    
    @IBAction func dismissKeyborad(_ sender: UITapGestureRecognizer) {
        dayOrganizationTextView.resignFirstResponder()
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageEvents.image = image
        } else {
            // error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
//    fileprivate let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameEventsLabel.text = SettingsRepository.nameEvents
        numberDaysLabel.text = SettingsRepository.numberDays 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        attendeesTableView.reloadData()
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InfoEvents.numberDaysArray.firstIndex(of: SettingsRepository.numberDays)! + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InfoEvents.numberDaysArray[row]
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
    
    
    // apply selected image on button
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        addPictureButton.setImage(nil, for: .normal)
//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            if  addPictureButton.backgroundImage(for: .normal) == nil {
//                addPictureButton.setBackgroundImage(image, for: .normal)
//            } else {
//                if addPictureButton.imageView?.description != image.description {
//                    addPictureButton.setBackgroundImage(image, for: .normal)
//                }
//            }
//            imagePicker.dismiss(animated: true, completion: nil)
//        }
//    }
    var enterInfoViewController = EnterInfoViewController()
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == segueIdentifier {
//            let personInfoVC = segue.destination as! PersonInfoViewController
//        }
//    }
}

// MARK: - TableView DataSource extension
extension AllInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    // MARK: - TableView Delegate extension
    // Lorsqu'on appui sur une cellue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedRecipe = hits?[indexPath.row].recipe
//        selectedRecipeImage = (tableView.cellForRow(at: indexPath) as! RecipeTableViewCell).picture.image
//        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            SettingsRepository.removeName(at: indexPath.row)
//            enterInfoViewController.names.remove(at: indexPath.row)
//            enterInfoViewController.removeName(indexName: indexPath.row)
            SettingsRepository.attendees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
