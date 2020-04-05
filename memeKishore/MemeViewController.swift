//
//  MemeViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 30/03/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Define outlets
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var imageFromCamera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!

    @IBOutlet weak var shareToolBar: UIToolbar!
    
    //Assign Delegates
    
    let text = TopandBottomText()
    
    // Create required instance
    let textStyles = TopandBottomText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareMemeButton.isEnabled = false
        //set camera disbaled if no camera in the device
        imageFromCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        view.contentMode = .scaleAspectFit
        self.topTextField.delegate = text
        self.bottomTextField.delegate = text
        textStyles.applyTextStyles(for: topTextField, Initialtext: "TOP")
        textStyles.applyTextStyles(for: bottomTextField, Initialtext: "BOTTOM")
        print("View did load executed")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe to Keyboard Notifications in order to know when keyboard is shown and hidden
           subscribeToKeyboardNotification()
         print("View will appear  executed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        print("View will Disappear executed")
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = generatedMemeAndText()
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
        print("User tapped on Share Button")
        
        share.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, complete: Bool, returnedItems: [Any]?, error: Error?) in
            if !complete {
                return
            }
            self.save(memedImage: image)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func selectImageForMemeFrom(_sender: UIBarButtonItem){
        let image = UIImagePickerController()
        if _sender == self.imageFromCamera {
            image.sourceType = .camera
        } else {
            image.sourceType = .photoLibrary
        }
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("image picker did cancel, User cancelled the image selection")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
               imagePicker.contentMode = .scaleAspectFit
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
        shareMemeButton.isEnabled = true
        print("User selected the image and returned to app")
    }
    
    func save(memedImage: UIImage) {
      let meme = MemeModel(toptextF1: topTextField.text!, bottomtextF2: bottomTextField.text!, image: imagePicker.image!  , finalmeme: memedImage )
    }
    
    func generatedMemeAndText() -> UIImage {
        // this is to hide the toolbar while generating memed Image
        disableRequiredBForMeme(istoolbarHidden: true, isSharebutton: false)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage :  UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Enable the toolbar unless the
        disableRequiredBForMeme(istoolbarHidden: false, isSharebutton: true)
        return memedImage
    }
    
    func disableRequiredBForMeme(istoolbarHidden hiddenToolBar: Bool, isSharebutton shareButtonStatus: Bool) {
        toolBar.isHidden = hiddenToolBar
        shareMemeButton.isEnabled = shareButtonStatus
        shareToolBar.isHidden = hiddenToolBar
        print("Tool bar's are disabled")
    }

    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        print("getKeyBoardHeight \(keyboardSize)")
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        print("subscribeToKeyboardNotification()")
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        print("unsubscribeFromKeyboardNotifications")
    }

    @objc func keyboardWillShow(_ notification: NSNotification){
        if bottomTextField.isFirstResponder {
             view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
}


