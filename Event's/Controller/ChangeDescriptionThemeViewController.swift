//
//  ChangeDescriptionThemeViewController.swift
//  Event's
//
//  Created by David Da Silva on 17/02/2022.
//

import UIKit

class ChangeDescriptionThemeViewController: UIViewController {
    
    // MARK: - Properties
//    var event: Event?
    private var themes: [String: String] = [:]
    var themeName = ""
//    weak var delegate: ThemeEnteredDelegate? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var nameTheme: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var allView: UIView!
    
    // MARK: - Actions
    @IBAction func registerButton(_ sender: Any) {
        AllInfoViewController.event?.themes[themeName] = descriptionTextView.text
        print(AllInfoViewController.event?.themes ?? [:])
//        delegate?.userDidEnteredTheme(keyTheme: themeName, valueTheme: descriptionTextView.text)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        descriptionTextView.resignFirstResponder()
    }
    
    @IBAction func share(_ sender: Any) {
        presentActivityController()
    }
    
    // MARK: - Functions
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTheme.text = themeName
        descriptionTextView.text = AllInfoViewController.event?.themes[themeName]
    }
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        ListEventsViewController.setTitleNav()
        navigationController?.navigationBar.topItem?.titleView = ListEventsViewController.titleNav
        design()
    }
    
    // Design of the different elements
    private func design() {
        viewName.layer.cornerRadius = 16
        registerButton.layer.cornerRadius = 16
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 16
    }
    
    // share and save image after swipe
    fileprivate func shareScreenshotOfGridContainer() -> UIActivityViewController {
        let sharedImage = [allView?.screenshot]
        let activityViewController = UIActivityViewController(activityItems: sharedImage as [Any], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = UIActivityViewController.CompletionWithItemsHandler? { [weak self]  _,_,_,_ in
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self?.allView?.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
        return activityViewController
    }

    // create animation when chooses a photo
    fileprivate func presentActivityController() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0, delay: 0, options: [.curveEaseIn], animations: {
//            guard let infoAttendees = self.allView else {
//                return
//            }
//            infoAttendees.transform = self.translation
        }, completion: { _ in
            let share = self.shareScreenshotOfGridContainer()
            self.present(share, animated: true)
        })
    }
}

