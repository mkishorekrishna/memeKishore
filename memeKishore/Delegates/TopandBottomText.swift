//
//  TopandBottomText.swift
//  memeKishore
//
//  Created by Kishore Krishna M on 01/04/20.
//  Copyright © 2020 Kishore Krishna M. All rights reserved.
//

import Foundation
import UIKit

class TopandBottomText : NSObject, UITextFieldDelegate {
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2.0
    ]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
            print("Clearing the default text")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField) ends editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        return true
    }
    
    func applyTextStyles(for field: UITextField, Initialtext: String) {
        field.textAlignment = .center
        field.defaultTextAttributes = memeTextAttributes
        field.backgroundColor = .clear
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocapitalizationType = .allCharacters
        field.text = Initialtext
        print("Required Text styles are applied for \(String(describing: field.text))")
    }
}
