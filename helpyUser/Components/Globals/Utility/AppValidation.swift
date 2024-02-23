//
//  AppValidation.swift
//  Helpy
//
//  Created by mac on 12/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import FormTextField
//MARK: ==========App Validation============
class AppValidation: NSObject {
    //MARK: ==========Name Validation==========
    static func isValidName(_ Name : String) -> Bool
    {
        let NameRegEx = "^\\w{3,18}$"
        let NameTest = NSPredicate(format: "SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: Name)
    }
    
    //MARK: ==========Email Validation==========
    static func isValidEmail(_ strEmail:String) -> Bool
    {
        let emailRegEx = "[A-Za-z]+[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
    }
    
    //MARK: ==========Mobile Number Validation==========
    static func isvalidMobileNo(_ phoneNo : String) -> Bool
    {
//        let PhoneRegEx = "^((\\+)|(00))[0-9]{6,14}$"//"^((\\+)|(00))[0-9]{6,14}$"
//        let PhoneTest = NSPredicate(format: "SELF MATCHES %@", PhoneRegEx)
//        return PhoneTest.evaluate(with: phoneNo)
        
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: phoneNo, options: [], range: NSRange(location: 0, length: phoneNo.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phoneNo.count
            } else {
                return false
            }
        } catch {
            return false
        }
        
    }
    
    //MARK: ==========Password Validation==========
    static func isValidPassword(_ Password: String) -> Bool
    {
        let PasswordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let PasswordTest = NSPredicate(format: "SELF MATCHES %@", PasswordRegEx)
        return PasswordTest.evaluate(with: Password)
    }
    func cardNumberField(_ textfield: FormTextField) -> FormTextField {
        var validation = Validation()
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        textfield.inputType = .integer
        textfield.formatter = CardNumberFormatter()
        textfield.inputValidator = InputValidator(validation: validation)
        return textfield
    }
}
