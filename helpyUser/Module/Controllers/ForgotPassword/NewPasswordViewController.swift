//
//  NewPasswordViewController.swift
//  helpyUser
//
//  Created by mac on 07/01/21.
//

import UIKit
import SkyFloatingLabelTextField

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var confirmpasswordView: UIView!
    @IBOutlet weak var newpasswordView: UIView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var txtnewpassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnNewpassword: UIButton!
    @IBOutlet weak var btnConfirmPassword: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFont()
        Set_WhitenavigationBar(Title: "OTP Verification", isneedback: true)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        btnSave.cornerRadius = btnSave.frame.size.width / 2
    }
    func setUp_UpdatePassword(){
        let mobileNo = UserDefaults.standard.string(forKey: "MobileNumber") ?? ""
        let NewPassword = txtnewpassword.text!
        let confirmPassword = txtConfirmPassword.text!
        if NewPassword == ""{
            AppUtility.alertMessage(passwodEmptyMessage, viewcontroller: self)
        }else if confirmPassword == ""{
            AppUtility.alertMessage(passwodEmptyMessage, viewcontroller: self)
        }else if confirmPassword != NewPassword{
            AppUtility.alertMessage("password is not Match", viewcontroller: self)
        }else if confirmPassword == NewPassword{
            LoaderManager.showLoader()
            APIManager.share.generateNewpassword(mobile: mobileNo, password: confirmPassword) { (Result) in
                LoaderManager.hideLoader()
                switch Result{
                case .success(let Response):
                    if Response.status == 1{
                      //  AppUtility.alertMessage(Response.message ?? "", viewcontroller: self)
                        
                        let LoginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
                        LoginVC.view.makeToast(Response.message ?? "")
                        self.navigationController?.pushViewController(LoginVC, animated: true)
                       
                    }else{
                        AppUtility.alertMessage(Response.message ?? "", viewcontroller: self)
                    }
                    break
                case .failure(let error):
                    AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                    break
                }
            }
        }
       
    }
    func setUpFont(){
        lbltitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 72)
        txtnewpassword.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 42)
        txtConfirmPassword.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 42)
        btnSave.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        
    }
    @IBAction func hideShowTapped(_ sender: UIButton) {
        
    }
    @IBAction func btnSavetapped(_ sender: UIButton) {
        setUp_UpdatePassword()
    }
    
}
