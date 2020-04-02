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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
       
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
