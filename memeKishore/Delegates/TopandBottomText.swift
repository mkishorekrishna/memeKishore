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
    
    // This is to make the current editing field as Active Field
    var activeField : UITextField?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TYPE TOP TEXT HERE" || textField.text == "TYPE BOTTOM TEXT HERE" {
            textField.text = ""
            print("Clearing the default text")
        }
        activeField = textField
        print("\(String(describing: activeField)) started editing")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        print("\(textField) ends editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
            newText = newText.replacingCharacters(in: range, with: string) as NSString
        return true
    }
     
    func applyTextStyles(for field: UITextField) {
        field.textAlignment = .center
        field.defaultTextAttributes = memeTextAttributes
        field.backgroundColor = .clear
        field.borderStyle = .none
        field.textAlignment = .center
        field.autocapitalizationType = .allCharacters
        print("Required Text styles are applied for \(String(describing: field.text))")
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.orange,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2.0
    ]
    
}
