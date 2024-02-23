//
//  ForgotpasswordViewController.swift
//  helpyUser
//
//  Created by mac on 07/01/21.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth

class ForgotpasswordViewController: UIViewController {

    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lbRegister: UILabel!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    
    var isGoForOTP: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFont()
        self.navigationController?.navigationBar.isHidden = false
        Set_WhitenavigationBar(Title: "Forgot Password", isneedback: true)
        
        if let countryCode = CountryCode().getPhoneCodeForCurrentUser() {
            txtMobileNumber.text = countryCode
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
        isGoForOTP = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnnext.cornerRadius = btnnext.frame.size.width / 2
    }
    override func viewDidLayoutSubviews() {
        
    }
    func setUpFont(){
        lblNumber.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 72)
        lbRegister.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 72)
        btnnext.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        txtMobileNumber.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 42)
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        let PhoneNumber = "\(txtMobileNumber.text ?? "")"
        UserDefaults.standard.set(txtMobileNumber.text ?? "", forKey: "MobileNumber")
        LoaderManager.showLoader()
        PhoneAuthProvider.provider().verifyPhoneNumber(PhoneNumber , uiDelegate: nil) { (VerificationID, error) in
            LoaderManager.hideLoader()
            if let error = error{
                print(error.localizedDescription)
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                return
            }
            if !self.isGoForOTP {
                let OtpVC = OTPViewController.instantiate(fromAppStoryboard: .Main)
                OtpVC.currentVerificationId = VerificationID ?? ""
                OtpVC.isforgot = true
                self.navigationController?.pushViewController(OtpVC, animated: true)
                self.isGoForOTP = true
            }
        }
        
    }
}
