//
//  AllInfoViewController.swift
//  Event's
//
//  Created by David Da Silva on 20/01/2022.
//

import UIKit

class AllInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var nameEventsLabel: UILabel!
    @IBOutlet weak var imageEvents: UIImageView!
    
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
        
        
//        let attendees = UserDefaults.standard.string(forKey: "attendees") ?? "Nom de l'evenement"
        nameEventsLabel.text = SettingsRepository.attendees
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InfoEvents.numberDaysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InfoEvents.numberDaysArray[row]
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

}
