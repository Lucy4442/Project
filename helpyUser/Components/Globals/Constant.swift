//
//  Constant.swift
//  Helpy
//
//  Created by mac on 04/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import  UIKit
import Toast_Swift

var btn : Bool = true

var style = ToastStyle()
var Index: Int = 0
var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
var isActivityIndicaterIsOn = false

//MARK: Validation  Message
var LoginSucess = "SucessFully Login"
var LoginFailed = "Login Failed"
var RegisterSucess = "Sucessfully Register"
var RegisterFailed = "Register Failed"
let EmailEmptyMessage = "Please Enter Email"
let EmailValidationMessage = "Please Enter Valid Email Address"
let passwodEmptyMessage = "Please Enter Password"
let passwordValidationMessage = "Password must contain Minimum 8 characters atleast 1 Alphabet, 1 Number and 1 Special Character"
let MobileNoEmptyMessage = "Please Enter Mobile Number"
let MobileNovalidationMessage = "Please Enter valid mobile Number"
let NameEmptyMessage = "Please Enter Name"
let NameValidationMessage = "Please Enter Atleast 3 character Name "
let MatchPasswordMessage = "Your Password And Confirm Password is not match"
var AddressEmptyMessage = "Please Enter Address"
var CityEmptyMessage = "Please Enter City"
var StateEmptyMessage = "Please enter State"
var profileEmptyMessage = "please set profile picture"
var CardNoEmptyMessage = "Please Enter CardNumber"
var CardExpireDateEmptyMessage = "Please Enter Card ExpireDate"
var CardExpireDateValidMessage = "Please Enter Valid ExpireDate"
var CardNoValidMessage = "Please enter valid Card Number"
var CardCVCEmptyMessage = "Please Enter Card CVC"
var CardHolderNameEmptyMessage = "Please Enter Card HolderName"
var cardSelectionMessage = "Please Select Card Type"
var LandmarkEmptyMessage = "Please enter LandMark"
var pincodeEmptyMessage = "Please enter valid Pincode"
let enterValidReason = "Enter valid reason"
var comingSoonMessage = "Coming Soon!!!"
var someThingWentWrongMessage = "Something Went Wrong! Please Try Again."
var pdfErrorMessage = "Can't download PDF, please try again letter"
var PleaseSelectLocationMessage = "Please select a location"
var weHaveFoundYourLocationMessage = "We have found address for your selected location, You want to fill it."
var userName = ""

///   this func for store userDefault Value
func setStringUserDefaultValue(value : String , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get userDefault Value
func getStringUserDefaultValue(key : UserDefaultKeys) -> String{
    return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
}
///   this func for store Int userDefault Value
func setIntegerUserDefaultValue(value : Int , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get Int userDefault Value
func getIntegerUserDefaultValue(key : UserDefaultKeys) -> Int{
    return UserDefaults.standard.integer(forKey: key.rawValue)
}
///   this func for store Boolean userDefault Value
func setBoolUserDefaultValue(value : Bool , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get Boolean userDefault Value
func getBoolUserDefaultValue(key : UserDefaultKeys) -> Bool{
    return UserDefaults.standard.bool(forKey: key.rawValue)
}
///   this func for store userDefault Value
func setDoubleUserDefaultValue(value : Double , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get userDefault Value
func getDoubleUserDefaultValue(key : UserDefaultKeys) -> Double{
    return UserDefaults.standard.double(forKey: key.rawValue)
}
func valueExists(forKey key: UserDefaultKeys) -> Bool {
    return UserDefaults.standard.value(forKey: key.rawValue) != nil
}
func showActivityIndicator(uiView: UIView) {
    isActivityIndicaterIsOn = true
    activityIndicator.style = UIActivityIndicatorView.Style.gray
    activityIndicator.tintColor = .gray
    activityIndicator.center = uiView.center
    uiView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
}

func hideActivityIndicator(uiView: UIView) {
    isActivityIndicaterIsOn = false
    activityIndicator.removeFromSuperview()
    activityIndicator.stopAnimating()
}
