//
//  OTPViewController.swift
//  helpyUser
//
//  Created by mac on 07/01/21.
//

import UIKit
import SVPinView
import FirebaseAuth
import IQKeyboardManagerSwift

class OTPViewController: UIViewController {

    @IBOutlet weak var imglogo: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var OTPView: SVPinView!
    @IBOutlet weak var lblReceiveOTP: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var password = ""
    var mobileNo = ""
    var socialID = ""
    var loginType = ""
    var currentVerificationId = ""
    var isforgot = false
    var isLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFont()
        appDelegate.isSetNavigationBar = true
        Set_WhitenavigationBar(Title: "OTP Verification", isneedback: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        IQKeyboardManager.shared.enable = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        setGradient_Nav()
        IQKeyboardManager.shared.enable = true
    }
    override func viewDidLayoutSubviews() {
        btnNext.cornerRadius = btnNext.frame.size.width / 2
        btnResend.roundCorners([.allCorners], radius: 15)
    }
    func setUpFont(){
        lbltitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 72)
        lblDetail.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 36)
        lblDetail.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 42)
        btnResend.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        btnNext.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblReceiveOTP.font = UIFont.AppFont(Name: FontName.Poppins_Regular, size: 42)
    }
    func login(mobileNO: String, password: String, LoginType: String, SocialID: String, email: String){
//        LoaderManager.showLoader()
//        APIManager.share.login(mobile: mobileNO, password: password, email: email, user_type: "4", login_type: LoginType, Social_id: SocialID, viewcontroller: self) { (Result) in
//            LoaderManager.hideLoader()
//            switch Result{
//            case .success(let response):
//                print("Response....\(response)")
//                if response.status == 1{
//                    UserDefaultManager.share.storeModelToUserDefault(userData: response.data, key: .LoginInfo)
//                    UserDefaults.standard.setValue(response.data?.token, forKey: "AuthToken")
//                    UserDefaults.standard.setValue(response.data?.user?.avatar ?? "", forKey: "Profile")
//                        setBoolUserDefaultValue(value: true, key: .isUserLogin)
//                    let user = LoggedInUser(socialID: SocialID, loginType: LoginType)
//                    UserDefaultManager.share.storeModelToUserDefault(userData: user, key: .LoggedInUser)
//                    let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
//                    homeVC.view.makeToast(response.message)
//                    self.navigationController?.pushViewController(homeVC, animated: true)
//                    UserDefaultStore.write(key: .isProfileComplated, value: true)
//                }else {
//                    style.messageColor = .red
//                    style.backgroundColor = .lightGray
//                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
//                }
//            case .failure(let error):
//                AppUtility.alertMessage(error.localizedDescription , viewcontroller: self)
//            }
//        }
    }
    func Register(mobileNo: String, password: String, socialID: String, LoginType: String, email: String){
//        UserDefaultStore.write(key: .isProfileComplated, value: false)
//        LoaderManager.showLoader()
//        APIManager.share.register(mobile: mobileNo, password: password, email: email, social_id: socialID, user_type: "4", login_type: LoginType, viewcontroller: self) { (result) in
//            LoaderManager.hideLoader()
//            switch result{
//            case .success(let response):
//                UserDefaults.standard.setValue(response.data?.token, forKey: "AuthToken")
//                if response.status == 1{
//                    if socialID == ""{
//                        let user = LoggedInUser(socialID: socialID, loginType: LoginType)
//                        UserDefaultManager.share.storeModelToUserDefault(userData: user, key: .LoggedInUser)
//                        setBoolUserDefaultValue(value: true, key: .isUserLogin)
//                        let ProfileVC = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
//                       // ProfileVC.txtMobileNumber.text = response.data?.user?.mobile
//                        ProfileVC.MobileNumber = mobileNo
//                        ProfileVC.view.makeToast(response.message)
//                        ProfileVC.isBackBarButtonHidden = true
//                        self.navigationController?.pushViewController(ProfileVC, animated: true)
//                    }else{
//                        let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
//                        homeVC.view.makeToast(response.message)
//                        self.navigationController?.pushViewController(homeVC, animated: true)
//                    }
//
//                }else{
//                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
//                }
//            case .failure(let error):
//                AppUtility.alertMessage("\(error.localizedDescription)", viewcontroller: self)
//                print(error)
//                break
//            }
//        }
    }
    @IBAction func resendTapped(_ sender: UIButton) {
        let Number = UserDefaults.standard.string(forKey: "Number")
//        LoaderManager.showLoader()
//        PhoneAuthProvider.provider().verifyPhoneNumber(Number ?? "", uiDelegate: nil) { (VerificationID, error) in
//            LoaderManager.hideLoader()
//            if let error = error{
//                print(error.localizedDescription)
//                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
//                return
//            }
//            self.view.makeToast("RE-SEND OTP Sucessfully")
//        }
    }
    @IBAction func btnnextTapped(_ sender: Any) {
        
        let otp = OTPView.getPin()
        let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
        homeVC.view.makeToast("Register sucessfully")
        self.navigationController?.pushViewController(homeVC, animated: true)
        //        if OTPView.getPin().count != 0{
        //            let credentials = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: otp)
        ////            Auth.auth().signIn(with: credentials) { (authResult, error) in
        ////
        ////                if authResult != nil{
        ////                    if self.isforgot == true{
        ////                        let NewPasswordVC = NewPasswordViewController.instantiate(fromAppStoryboard: .Main)
        ////                        self.navigationController?.pushViewController(NewPasswordVC, animated: true)
        ////                    }else{
        ////                        if self.socialID == ""{
        ////                            if self.isLogin == true{
        ////                                self.login(mobileNO: self.mobileNo, password: "", LoginType: "1", SocialID: "", email: "")
        ////                            }else{
        ////                                self.Register(mobileNo: self.mobileNo, password: self.password, socialID: self.socialID, LoginType: self.loginType, email: "")
        ////                            }
        ////                        }else{
        ////                            let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
        ////                            homeVC.view.makeToast("Register sucessfully")
        ////                            self.navigationController?.pushViewController(homeVC, animated: true)
        ////                        }
        ////                    }
        ////                }else{
        ////                    AppUtility.alertMessage("Please Enter Valid OTP", viewcontroller: self)
        ////                }
        ////            }
        //        }else{
        //            AppUtility.alertMessage("Please Enter OTP", viewcontroller: self)
        //        }
    }
}
