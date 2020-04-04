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
        //set intitial text
        self.topTextField.text = "TYPE TOP TEXT HERE"
        self.bottomTextField.text = "TYPE BOTTOM TEXT HERE"
        textStyles.applyTextStyles(for: topTextField)
        textStyles.applyTextStyles(for: bottomTextField)
        print("View did load executed")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe to Keyboard Notifications in order to know when keyboard is shown and hidden
           subscribeToKeyboardNotification()
           subscribeToKeyboardHideNotification()
         print("View will appear  executed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardHideNotification()
        textStyles.applyTextStyles(for: bottomTextField)
        print("View will Disappear executed")
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = generatedMemeAndText()
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
        print("User tapped on Share Button")
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        print("user tapped on album Button")
    }
    
    @IBAction func pickImagefromCamera(_ sender: Any) {
        let imagefromCamera = UIImagePickerController()
        imagefromCamera.delegate = self
        imagefromCamera.sourceType = .camera
        present(imagefromCamera, animated: true, completion: nil)
        print("user tapped on camera Button")
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
    
    func save() {
        let memedImage = generatedMemeAndText()
        _ = Meme(toptextF1: topTextField.text!, bottomtextF2: bottomTextField.text!, image: imagePicker.image!  , finalmeme: memedImage )
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
    
    //
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        print("getKeyBoardHeight \(keyboardSize)")
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        print("subscribeToKeyboardNotification()")
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        print("unsubscribeFromKeyboardNotifications")
    }
    func subscribeToKeyboardHideNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        print("subscribeToHideKeyboardNotification()")
    }

    func unsubscribeFromKeyboardHideNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        print("subscribeToHideKeyboardNotification()")
    }
    
    
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        var aRect : CGRect = self.view.frame
        aRect.size.height -= getKeyboardHeight(notification)
        if let activeTextField = text.activeField {
            if(!aRect.contains(activeTextField.frame.origin)){
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    
    
}
struct Meme {
    var toptextF1 : String
    var bottomtextF2 : String
    var image : UIImage
    var finalmeme : UIImage
}

