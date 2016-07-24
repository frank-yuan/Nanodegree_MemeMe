//
//  MemeEditTextFieldDelegate.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/20/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//
import Foundation
import UIKit

class MemeEditTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
}
