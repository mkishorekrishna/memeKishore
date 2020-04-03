//
//  ViewController.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 30/03/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var imageFromCamera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareMemeButton: UIButton!
    
    
    //assign Delegates
    
    let text = TopandBottomText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.topTextField.delegate = text
        self.bottomTextField.delegate = text
        //set intitial text
        self.topTextField.text = "Type Top text here"
        self.bottomTextField.text = "Type Botton text here"
        self.topTextField.textAlignment = .center
        self.bottomTextField.textAlignment = .center
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.subscribeToKeyboardNotification()
        self.subscribeToKeyboardHideNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor : UIColor.blue,
        NSAttributedString.Key.foregroundColor: UIColor.red,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2.0
    ]
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = generatedMemeAndText()
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImagefromCamera(_ sender: Any) {
        let imagefromCamera = UIImagePickerController()
        imagefromCamera.delegate = self
        imagefromCamera.sourceType = .camera
        present(imagefromCamera, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePicker.contentMode = .scaleAspectFit
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
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
    
    func save() {
        let memedImage = generatedMemeAndText()
        _ = Meme(toptextF1: topTextField.text!, bottomtextF2: bottomTextField.text!, image: imagePicker.image!  , finalmeme: memedImage )
    }
    
    
    func generatedMemeAndText() -> UIImage {
        // this is to hide the toolbar while generating memed Image
        _ = disablerequired(hidden: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage :  UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Enable the toolbar unless the
        disablerequired(hidden: false)
        return memedImage
    }
    
    func disablerequired(hidden: Bool) {
        toolBar.isHidden = hidden
        shareMemeButton.isHidden = hidden
    }

}
struct Meme {
    var toptextF1 : String
    var bottomtextF2 : String
    var image : UIImage
    var finalmeme : UIImage
}

