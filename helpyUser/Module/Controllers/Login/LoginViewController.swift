//
//  LoginViewController.swift
//  Helpy
//
//  Created by mac on 09/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleSignIn
import Toast_Swift
import SkyFloatingLabelTextField
import FBSDKLoginKit
import Moya
import Firebase

//MARK: =====Login ViewController=====
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: ======Outlet======
    @IBOutlet weak var lblSignUptitle: UILabel!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnForgotpassword: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnHideShow: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtNumber: SkyFloatingLabelTextField!
    
    //MARK: ======Variable======
    //var optiontitle = optionSelection.User
    
    var isGoForOTP: Bool = false
    
    //MARK: =====viewDidLoad=====
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        txtNumber.delegate = self
        txtNumber.returnKeyType = .next
        txtPassword.returnKeyType = .go
        txtPassword.delegate = self
        setGradient_Nav()
        SetUpFont()
        let colorTop =  UIColor.App_DarkBlue?.cgColor
        let colorBottom = UIColor.App_LightBlue?.cgColor
        self.navigationController?.navigationBar.setGradientBackground(colors: [colorTop!,colorBottom!])
        if let countryCode = CountryCode().getPhoneCodeForCurrentUser() {
            txtNumber.text = countryCode
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        isGoForOTP = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    //MARK: =====viewDidLayoutSubviews=====
    override func viewDidLayoutSubviews() {
        btnGoogle.roundCorners([.allCorners], radius: btnGoogle.frame.size.height * 0.32)
        btnApple.roundCorners([.allCorners], radius: btnApple.frame.size.height * 0.32)
        btnFacebook.roundCorners([.allCorners], radius: btnFacebook.frame.size.height * 0.32)
        btnLogin.layer.cornerRadius = btnLogin.frame.size.height / 2
        
    }
    
    func SetUpFont() {
        self.btnGoogle.titleLabel?.font = UIFont.Medium
        self.btnGoogle.setTitleColor(UIColor.App_NavyBlue, for: .normal)
        self.btnFacebook.titleLabel?.font = UIFont.Medium
        self.btnFacebook.setTitleColor(UIColor.App_NavyBlue, for: .normal)
        self.txtNumber.textColor = UIColor.App_NavyBlue
        self.txtNumber.font = UIFont.Regular
        self.txtPassword.textColor = UIColor.App_NavyBlue
        self.txtPassword.font = UIFont.Regular
        btnSignup.titleLabel?.font = UIFont.Semi_Bold
        lblSignUptitle.font = UIFont.Regular
        btnLogin.titleLabel?.font = UIFont.Medium
        btnForgotpassword.titleLabel?.font = UIFont.Semi_Bold
    }
    //MARK: ==========textField Delegate==========
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtNumber {
            txtPassword.becomeFirstResponder()
        }else{
            btnLogin.sendActions(for: .touchUpInside)
        }
        return true
    }
    
    @IBAction func btnappleTapped(_ sender: Any) {
        AppUtility.alertMessage("Under Devlopment", viewcontroller: self)
    }
    @IBAction func btnGoogleTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnFacebookTapped(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if(error != nil){
                loginManager.logOut()
            }else if result!.isCancelled {
                loginManager.logOut()
            }else{
                self.getFBUserData()
            }
        }
    }
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! [String : AnyObject]
                    guard let id = fbDetails["id"] as? String ,id != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    
                    guard let name = fbDetails["first_name"] as? String ,name != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    guard let email = fbDetails["email"] as? String ,email != "" else {
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        return
                    }
                    
                    print("FB account Detail : \(fbDetails)")
                    //self.socialLogin(socialID: id, LoginType: "3")
                    self.login(mobileNO: "", password: "", LoginType: "3", SocialID: id, email: email)
                }
                else{
                    print("error :\(error?.localizedDescription ?? "") ")
                }
            })
        }
    }
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let ForgotPasswordVC = ForgotpasswordViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(ForgotPasswordVC, animated: true)
    }
    //MARK: =====Login button Action=====
    @IBAction func btnLoginTaapped(_ sender: Any) {
        print("Login Tapped......")
        let Number = txtNumber.text!
        if txtNumber.text == ""{
            self.view.makeToast(MobileNoEmptyMessage)
        }else if !AppValidation.isvalidMobileNo(txtNumber.text ?? ""){
            self.view.makeToast(MobileNovalidationMessage)
        }else{
            login(mobileNO: Number, password: "", LoginType: "1", SocialID: "", email: "")
        }
    }
    func login(mobileNO: String, password: String, LoginType: String, SocialID: String, email: String){
        LoaderManager.showLoader()
        APIManager.share.login(mobile: mobileNO, password: password, email: email, user_type: "4", login_type: LoginType, Social_id: SocialID, viewcontroller: self) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print("Response....\(response)")
                if response.status == 1{
                    UserDefaultManager.share.storeModelToUserDefault(userData: response.data, key: .LoginInfo)
                    UserDefaults.standard.setValue(response.data?.token, forKey: "AuthToken")
                    UserDefaults.standard.setValue(response.data?.user?.avatar ?? "", forKey: "Profile")
                    let user = LoggedInUser(socialID: SocialID, loginType: LoginType)
                    UserDefaultManager.share.storeModelToUserDefault(userData: user, key: .LoggedInUser)
                    setBoolUserDefaultValue(value: true, key: .isUserLogin)
                        if SocialID != ""{
                            if response.data?.user?.name == nil{
                                let ProfileVc = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
                                ProfileVc.isupdateprofile = true
                                ProfileVc.loginType = LoginType
                                ProfileVc.socialID = SocialID
                                ProfileVc.MobileNumber = nil
                                ProfileVc.isBackBarButtonHidden = true
                                self.navigationController?.pushViewController(ProfileVc, animated: true)
                            }else{
                                let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
                                self.navigationController?.pushViewController(homeVC, animated: true)
                                UserDefaultStore.write(key: .isProfileComplated, value: true)
                            }
                        }else{
                            self.OTPverification(Number: mobileNO, password: "")
                        }
                }else {
                    style.messageColor = .red
                    style.backgroundColor = .lightGray
                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
                }
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription , viewcontroller: self)
            }
        }
    }
    func OTPverification(Number: String, password: String){
        let PhoneNumber = "\(Number)"
        UserDefaults.standard.set(txtNumber.text ?? "", forKey: "Number")
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
                OtpVC.isLogin = true
                OtpVC.currentVerificationId = VerificationID ?? ""
                OtpVC.loginType = "1"
                OtpVC.password = password
                OtpVC.mobileNo = Number
                self.navigationController?.pushViewController(OtpVC, animated: true)
                self.isGoForOTP = true
            }
        }
    }
    func socialLogin(socialID: String, LoginType: String){
        let ProfileVc = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
        ProfileVc.loginType = LoginType
        ProfileVc.socialID = socialID
        ProfileVc.MobileNumber = nil
        ProfileVc.isBackBarButtonHidden = true
        self.navigationController?.pushViewController(ProfileVc, animated: true)
    }
    //MARK: =====Signup button Action=====
    @IBAction func btnSignupTapped(_ sender: UIButton) {
        let RegisterVC = RegisterViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    //MARK: =====Password hide/show button Action=====
    @IBAction func btnHideShowTapped(_ sender: UIButton) {
        btn = !btn
        if sender.tag == 0 {
            if(btn){
                btnHideShow.setImage(UIImage(named: ImageName.Hide), for: .normal)
                txtPassword.isSecureTextEntry = true
            }else{
                btnHideShow.setImage(UIImage(named: ImageName.Show), for: .normal)
                txtPassword.isSecureTextEntry = false
            }
        }else{
            if(btn){
                btnHideShow.setImage(UIImage(named: ImageName.Hide), for: .normal)
                txtPassword.isSecureTextEntry = true
            }else{
                btnHideShow.setImage(UIImage(named: ImageName.Show), for: .normal)
                txtPassword.isSecureTextEntry = false
            }
        }
        
    }
}
extension LoginViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}
extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!,
              didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        let userId = user.userID ?? ""
        //        let idToken = user.authentication.idToken
        //        let fullName = user.profile.name
        //        let givenName = user.profile.givenName
        //        let familyName = user.profile.familyName
        let email = user.profile.email ?? ""
        self.login(mobileNO: "", password: "", LoginType: "2", SocialID: userId, email: email)
        //        self.socialLogin(socialID: userId, LoginType: "2")
    }
}
