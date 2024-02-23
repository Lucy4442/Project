//
//  ProfileViewController.swift
//  helpyUser
//
//  Created by mac on 12/01/21.
//
enum ImageSource {
    case photoLibrary
    case camera
}

import UIKit
import SkyFloatingLabelTextField
import Firebase
class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtState: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCity: SkyFloatingLabelTextField!
    @IBOutlet weak var txtAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var pinCodeTextFeild: SkyFloatingLabelTextField!
    @IBOutlet weak var landMarkTextFeild: SkyFloatingLabelTextField!
    @IBOutlet weak var mapView: UIView!
    
    var imagePicker: UIImagePickerController!
    var profileData : UserProfileData?
    var socialID = ""
    var loginType = ""
    var MobileNumber : String?
    var isupdateprofile = false
    var isBackBarButtonHidden = false
    var isGoForOTP: Bool = false
    var selectedLocation : locationPosition? {
        didSet {
            updateMapLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Profile", isneedback: true)
        
        appDelegate.isSetNavigationBar = true
        if isupdateprofile == false{
            GetProfileData()
            txtMobileNumber.isUserInteractionEnabled = true
        }else{
            txtMobileNumber.text = MobileNumber ?? CountryCode().getPhoneCodeForCurrentUser().asStringOrEmpty()
            txtMobileNumber.isUserInteractionEnabled = true
        }
        
        setUpMap()
    }
    override func viewDidLayoutSubviews() {
        btnSave.cornerRadius = btnSave.frame.size.width / 2
        imgProfile.cornerRadius = imgProfile.frame.size.height / 2
        imgProfile.contentMode = .scaleAspectFill
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        setGradient_Nav()
        isGoForOTP = false
        if isBackBarButtonHidden {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    func GetProfileData(){
//        LoaderManager.showLoader()
//        APIManager.share.UserProfileData { (Result) in
//            LoaderManager.hideLoader()
//            switch Result{
//            case .success(let response):
//                print("Response user profile: \(response)")
//                self.profileData = response.UserData
//                self.txtName.text = response.UserData?.name
//                self.txtCity.text = response.UserData?.city
//                self.txtState.text = response.UserData?.state
//                let mobileNumber = response.UserData?.mobile
//                if mobileNumber == nil {
//                    self.isupdateprofile = true
//                    self.txtMobileNumber.isUserInteractionEnabled = true
//                }
//                self.txtMobileNumber.text = mobileNumber ?? (self.MobileNumber ?? CountryCode().getPhoneCodeForCurrentUser().asStringOrEmpty())
//                self.txtAddress.text = response.UserData?.address
//                self.imgProfile.getImage(url: response.UserData?.avatar ?? "", placeholderImage: ImageName.Userplaceholder)
//                self.pinCodeTextFeild.text = response.UserData?.pincode?.description
//                self.landMarkTextFeild.text = response.UserData?.landmark
//                if let latitude = Double((response.UserData?.latitude).asStringOrEmpty()), let longitude = Double((response.UserData?.longitude).asStringOrEmpty()) {
//                    self.selectedLocation = (latitude,longitude)
//                }
//                break
//            case .failure(let error):
//                print("Response get Profile Detail: \(error.localizedDescription)")
//                self.view.makeToast(error.localizedDescription)
//                break
//            }
//        }
    }
    
    @IBAction func profileCameraTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: AppStoryboard.Main.rawValue, bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "DocumentPopupViewController") as? DocumentPopupViewController {
            popupVC.superVC = self
            popupVC.height = 380//IScreen.main.bounds.height / 2
            popupVC.topCornerRadius = 32
            popupVC.presentDuration = 0.5
            popupVC.dismissDuration = 0.5
            popupVC.shouldDismissInteractivelty = true
            popupVC.Delegate = self
            present(popupVC, animated: true, completion: nil)
        }
    }
    func isAllDataValid() -> Bool{
        var isValid = true
        if txtName.text == ""{
            isValid = false
            AppUtility.alertMessage(NameEmptyMessage, viewcontroller: self)
        }else if txtMobileNumber.text == ""{
            isValid = false
            AppUtility.alertMessage(MobileNoEmptyMessage, viewcontroller: self)
        }else if !AppValidation.isvalidMobileNo(txtMobileNumber.text ?? ""){
            isValid = false
            AppUtility.alertMessage(MobileNovalidationMessage, viewcontroller: self)
        }else if txtAddress.text == ""{
            isValid = false
            AppUtility.alertMessage(AddressEmptyMessage, viewcontroller: self)
        }else if txtCity.text == ""{
            isValid = false
            AppUtility.alertMessage(CityEmptyMessage, viewcontroller: self)
        }else if txtState.text == ""{
            isValid = false
            AppUtility.alertMessage(StateEmptyMessage, viewcontroller: self)
        } else if pinCodeTextFeild.text == "" {
            isValid = false
            AppUtility.alertMessage(pincodeEmptyMessage, viewcontroller: self)
        } else if selectedLocation == nil {
            isValid = false
            AppUtility.alertMessage(PleaseSelectLocationMessage, viewcontroller: self)
        }
        return isValid
    }
    func UpdateProfileData(completion: @escaping ((Bool) -> Void)){
        
        if isAllDataValid(){
            let Name = txtName.text!
            let MobileNo = txtMobileNumber.text!
            let Address = txtAddress.text!
            let City = txtCity.text!
            let State = txtState.text!
            let Landmark = landMarkTextFeild.text!
            let Pincode = pinCodeTextFeild.text!
            var profiledata =  imgProfile.image?.jpegData(compressionQuality: 1.0) ?? Data()
            let latitude = (selectedLocation?.latitude.description).asStringOrEmpty()
            let longitude = (selectedLocation?.longitude.description).asStringOrEmpty()
            profiledata = countSizeofFile(ImageData: profiledata) ?? Data()
            LoaderManager.showLoader()
            APIManager.share.UpdateProfile(name: Name, mobile: MobileNo, address: Address, city: City, state: State, Avatar: profiledata, user_type: "4",landMark: Landmark,pinCode: Pincode,latitude: latitude,longitude: longitude) { (Result) in
                LoaderManager.hideLoader()
                switch Result{
                case .success(let response):
                    if response.status == 1{
                        UserDefaultManager.share.storeModelToUserDefault(userData: response.userdata, key: .ProfileInfo)
                        UserDefaults.standard.setValue(response.userdata?.avatar ?? "", forKey: "Profile")
                        completion(true)
                    }else{
                        completion(false)
                        AppUtility.alertMessage(response.message ?? "", viewcontroller: self)
                    }
                case .failure(let error):
                    completion(false)
                    AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                    break
                }
            }
        }
    }
    func countSizeofFile(ImageData: Data?) -> Data?{
        var profiledata = ImageData
        if let data = ImageData {
            var compressionQuality : CGFloat = 1.0
            
            print("There were \(data.count) bytes")
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useMB]
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(data.count))
            print("formatted result: \(string)")
            if let fileSize = string.split(separator: " ").first{
                if Float(fileSize) ?? 0 > 5.0 {
                    compressionQuality = compressionQuality / 2
                    profiledata =  imgProfile.image?.jpegData(compressionQuality: compressionQuality) ?? Data()
                    profiledata = countSizeofFile(ImageData: profiledata)
                }
            }
        }
        return profiledata
    }
    func OTPverification(Number: String, socialID: String, loginType: String){
        let PhoneNumber = "\(Number)"
        LoaderManager.showLoader()
        PhoneAuthProvider.provider().verifyPhoneNumber(PhoneNumber , uiDelegate: nil) { (VerificationID, error) in
            LoaderManager.hideLoader()
            if let error = error{
                print(error.localizedDescription)
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                return
            }
            self.UpdateProfileData { (isSucess) in
                if isSucess{
                    if !self.isGoForOTP {
                        let OtpVC = OTPViewController.instantiate(fromAppStoryboard: .Main)
                        OtpVC.currentVerificationId = VerificationID ?? ""
                        OtpVC.mobileNo = Number
                        OtpVC.socialID = socialID
                        OtpVC.loginType = loginType
                        self.navigationController?.pushViewController(OtpVC, animated: true)
                        UserDefaultStore.write(key: .isProfileComplated, value: true)
                        self.isGoForOTP = true
                    }
                }
            }
        }
    }
    
    
    func setUpMap() {
        let map = HelpyLocationView.instantiate()
        map.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: mapView.frame.size)
        map.preferedLocation = selectedLocation
        map.delegate = self
        mapView.addSubview(map)
        mapView.roundCorners(.allCorners, radius: 12)
        mapView.maskToBounds = true
    }
    
    func updateMapLocation() {
        if let map = mapView.subviews.first as? HelpyLocationView {
            if let location = selectedLocation {
                map.setUp(location: location)
                map.preferedLocation = selectedLocation
            }
        }
    }
    
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        view.endEditing(true)
//        if isupdateprofile == true{
//            if isAllDataValid(){
//                self.OTPverification(Number: txtMobileNumber.text ?? "", socialID: socialID, loginType: loginType)
//            }
//        }else{
//            UpdateProfileData { (isSucess) in
//                if isSucess{
        let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
        homeVC.view.makeToast("Update profile sucessfully")
        userName = self.txtName.text ?? ""
        homeVC.setGradient_Nav()
        self.navigationController?.pushViewController(homeVC, animated: true)
//                    UserDefaultStore.write(key: .isProfileComplated, value: true)
//                } else {
//                    self.setUpBackButton()
//                }
//            }
//        }
        
    }
}
extension ProfileViewController : LoadImageDelegate{
    
    func LoadImage(Index: Int, DocumentImage: UIImage?) {
        self.imgProfile.image = DocumentImage
    }
    
}


extension ProfileViewController: LocationDelegate {
    
    func location(_ locationViewController: UIViewController, didFinishPicking location: locationPosition, with Address: locationAddress?) {
        self.selectedLocation = location
        if let address = Address {
            requstUserForFillAddressAuto(with: address)
        }
    }
    
    func requstUserForFillAddressAuto(with address: locationAddress) {
        let alertMessage = """
            \(weHaveFoundYourLocationMessage)
            \(address.address) \(address.pinCode) \(address.landMark) \(address.city) \(address.state)
            """
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            AppUtility.alertMessage(alertMessage, viewcontroller: self,okAction: { _ in
                self.fillAddress(from: address)
            }, cancelAction:  { _ in })
        }
    }
    
    func fillAddress(from locationAddress: locationAddress) {
        self.txtAddress.text = locationAddress.address
        self.pinCodeTextFeild.text = locationAddress.pinCode
        self.landMarkTextFeild.text = locationAddress.landMark
        self.txtCity.text = locationAddress.city
        self.txtState.text = locationAddress.state
    }
    
}
