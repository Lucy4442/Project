//
//  RegisterViewController.swift
//  Helpy
//
//  Created by mac on 09/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Moya
import SkyFloatingLabelTextField
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth

//MARK: =====RegisterViewController=====
class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: ======Outlet======
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnHideShow: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var lblloginTitle: UILabel!
    @IBOutlet weak var txtReferralCode: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollViewSignUp: UIScrollView!
    @IBOutlet weak var viewBottom: UIView!
    
    var isGoForOTP: Bool = false
    
    //MARK: =====viewDidLoad=====
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMobileNumber.delegate = self
        txtReferralCode.delegate = self
        txtPassword.delegate = self
        txtMobileNumber.returnKeyType = .next
        txtReferralCode.returnKeyType = .next
        txtPassword.returnKeyType = .next
        scrollViewSignUp.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: viewBottom.frame.height, right: 0)
        setUpFont()
        let colorTop =  UIColor.App_DarkBlue?.cgColor
        let colorBottom = UIColor.App_LightBlue?.cgColor
        self.navigationController?.navigationBar.setGradientBackground(colors: [colorTop!,colorBottom!])
        
        if let countryCode = CountryCode().getPhoneCodeForCurrentUser() {
            txtMobileNumber.text = countryCode
        }
        
        txtMobileNumber.text = "+91 9988775425"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        GIDSignIn.sharedInstance().delegate = self
        isGoForOTP = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    //MARK: =====viewDidLayoutSubviews=====
    override func viewDidLayoutSubviews() {
        btnSignup.layer.cornerRadius = btnSignup.frame.size.height / 2
        btnGoogle.roundCorners([.allCorners], radius: btnGoogle.frame.size.height * 0.32)
        btnApple.roundCorners([.allCorners], radius: btnApple.frame.size.height * 0.32)
        btnFacebook.roundCorners([.allCorners], radius: btnFacebook.frame.size.height * 0.32)
    }
    
    //MARK: ==========textField Delegate==========
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField == txtMobileNumber{
            txtMobileNumber.becomeFirstResponder()
        }else if textField == txtPassword{
            txtPassword.becomeFirstResponder()
        }else if textField == txtReferralCode{
            txtReferralCode.becomeFirstResponder()
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkmobileNumber()
    }
    func setUpFont() {
        btnGoogle.titleLabel?.font = UIFont.Medium
        btnGoogle.setTitleColor(UIColor.App_NavyBlue, for: .normal)
        btnFacebook.titleLabel?.font = UIFont.Medium
        btnFacebook.setTitleColor(UIColor.App_NavyBlue, for: .normal)
        btnLogin.titleLabel?.font = UIFont.Semi_Bold
        btnLogin.setTitleColor(UIColor.App_LightBlue, for: .normal)
        txtMobileNumber.font = UIFont.Regular
        txtMobileNumber.textColor = UIColor.App_NavyBlue
        txtReferralCode.font = UIFont.Regular
        txtReferralCode.textColor = UIColor.App_NavyBlue
        txtPassword.font = UIFont.Regular
        txtPassword.textColor = UIColor.App_NavyBlue
        lblloginTitle.textColor = UIColor.App_NavyBlue
        lblloginTitle.font = UIFont.Regular
        btnSignup.titleLabel?.font = UIFont.Medium
        
    }
    //MARK: =====Signup button Action=====
    @IBAction func btnSignupTapped(_ sender: UIButton) {
        print("Register button Tapped")
        if txtMobileNumber.text == ""{
            self.view.makeToast(MobileNoEmptyMessage)
        }else if !AppValidation.isvalidMobileNo(txtMobileNumber.text ?? ""){
            self.view.makeToast(MobileNovalidationMessage)
        }else{
            self.OTPverification(Number: txtMobileNumber.text ?? "", password: txtPassword.text ?? "")
        }
        
    }
    func checkmobileNumber(){
        APIManager.share.checkMobileNumber(user_type: "4", MobileNumber: txtMobileNumber.text ?? "") { (Result) in
            switch Result{
            case .success(let response):
                if response.isRegister == 1{
                    AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
                }
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    func login(mobileNO: String, password: String, LoginType: String, SocialID: String, email: String){
        UserDefaultStore.write(key: .isProfileComplated, value: false)
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
                        setBoolUserDefaultValue(value: true, key: .isUserLogin)
                    let user = LoggedInUser(socialID: SocialID, loginType: LoginType)
                    UserDefaultManager.share.storeModelToUserDefault(userData: user, key: .LoggedInUser)
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
    func socialLogin(socialID: String, LoginType: String){
        let ProfileVc = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
        ProfileVc.loginType = LoginType
        ProfileVc.socialID = socialID
        ProfileVc.MobileNumber = nil
        ProfileVc.isupdateprofile = true
        ProfileVc.isBackBarButtonHidden = true
        self.navigationController?.pushViewController(ProfileVc, animated: true)
    }
    func OTPverification(Number: String, password: String){
        let PhoneNumber = "\(Number)"
        UserDefaults.standard.set(txtMobileNumber.text ?? "", forKey: "Number")
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
                OtpVC.loginType = "1"
                OtpVC.password = password
                OtpVC.mobileNo = PhoneNumber
                self.navigationController?.pushViewController(OtpVC, animated: true)
                self.isGoForOTP = true
            }
        }
    }
    @IBAction func btnFacebookTapped(_ sender: Any) {
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
//                    self.socialLogin(socialID: id, LoginType: "3")
                    self.login(mobileNO: "", password: "", LoginType: "3", SocialID: id, email: email)
                }
                else{
                    print("error :\(error?.localizedDescription ?? "") ")
                }
            })
        }
    }
    @IBAction func btnGoogletapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func btnAppletapped(_ sender: Any) {
        AppUtility.alertMessage("Under Devlopment", viewcontroller: self)
    }
    //MARK: =====Login button Action=====
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        //TODO: when enteralready register number in mobile number field set alert for already register number
        let LoginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    //MARK: =====Password hide/show button Action=====
    @IBAction func btnHideShowTapped(_ sender: UIButton) {
        btn = !btn
        if (btn) {
            btnHideShow.setImage(UIImage(named: ImageName.Hide), for: .normal)
            
            txtPassword.isSecureTextEntry = true
           
        }else{
            btnHideShow.setImage(UIImage(named: ImageName.Show), for: .normal)
            
            txtPassword.isSecureTextEntry = false
    
        }
    }
}
extension RegisterViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }

}
extension RegisterViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(".........")
    }
    
    
//    func sign(_ signIn: GIDSignIn!,
//              didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//
//        // Check for sign in error
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//                print("The user has not signed in before or they have since signed out.")
//            } else {
//                print("\(error.localizedDescription)")
//            }
//            return
//        }
//        let userId = user.userID ?? ""
//        //let email = user.profile.email ?? ""
////        self.socialLogin(socialID: userId, LoginType: "2")
//        self.login(mobileNO: "9988776644", password: "Test@1234", LoginType: "2", SocialID: userId, email: "")
//    }
}
