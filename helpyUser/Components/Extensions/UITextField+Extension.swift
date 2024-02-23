//
//  UITextField+Extension.swift
//  Helpy
//
//  Created by mac on 08/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import FormTextField
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    func cardNumberField() -> InputValidatable{
        let textField = FormTextField(frame: self.bounds)
        textField.inputType = .integer
        textField.formatter = CardNumberFormatter()
        var validation = Validation()
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator
        return inputValidator
    }
    func cardExpirationDateField() {
        let textField = FormTextField(frame: self.frame)
        textField.inputType = .integer
        textField.formatter = CardExpirationDateFormatter()
        var validation = Validation()
        validation.minimumLength = 1
        let inputValidator = CardExpirationDateInputValidator(validation: validation)
        textField.inputValidator = inputValidator
    }
    func cvcField(){
        let textField = FormTextField(frame: self.frame)
        textField.inputType = .integer
        var validation = Validation()
        validation.maximumLength = "CVC".count
        validation.minimumLength = "CVC".count
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator
    }
}
