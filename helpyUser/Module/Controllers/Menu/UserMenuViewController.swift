//
//  UserMenuViewController.swift
//  Helpy
//
//  Created by mac on 17/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn
import FBSDKLoginKit
//MARK: ========== UseMenu ==========
class UserMenuViewController: UIViewController {
    
    //MARK: ==========Outlet==========
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var UserMenuTableView: UITableView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var profileborder: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var Username: UILabel!
    //MARK: ======Variable======
    var MenuIcon = [UIImage(named: ImageName.help ), UIImage(named: ImageName.term_condition), UIImage(named: ImageName.privacyPolicy), UIImage(named: ImageName.aboutus)]
    var Menuitem = [LabelName.Help, LabelName.term_condition, LabelName.privacy_policy, LabelName.About_US]
    var address = ""
    var name = ""
    var cardDetail : GetCardDetails?
    
    //MARK: ===========viewDidLoad==========
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpRegisterNIB()
        Set_navigationBar(Title: "", isneedback: true)
        GetProfileData()
        let profileimage = UserDefaults.standard.string(forKey:"Profile") ?? ""
//        if let Name = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserData.self, key: .ProfileInfo)?.name{
//            name = Name
//        }else{
//            name = UserDefaultManager.share.getModelDataFromUserDefults(userData: LoginData.self, key: .LoginInfo)?.user?.name ?? ""
//        }
//        let City = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserData.self, key: .ProfileInfo)?.address?.city
//        let state = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserData.self, key: .ProfileInfo)?.address?.state ?? ""
//        if let Add = City{
//            self.address = Add + "," + state
//        }else{
//            self.address =  "\(UserDefaultManager.share.getModelDataFromUserDefults(userData: UserProfileData.self, key: .UserProfileInfo)?.city ?? ""), \(UserDefaultManager.share.getModelDataFromUserDefults(userData: UserProfileData.self, key: .UserProfileInfo)?.state ?? "")"
//        }
        Username.text = userName
        lblAddress.text = address
        imgprofile.getImage(url: profileimage, placeholderImage: ImageName.Userplaceholder)
        GetCardDetail_data()
    }
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: ======viewDidLayoutSubviews======
    override func viewDidLayoutSubviews() {
        ProfileView.cornerRadius = ProfileView.frame.size.height / 4
        TopView.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        imgprofile.cornerRadius = imgprofile.frame.size.width / 2
        profileborder.cornerRadius = profileborder.frame.size.width / 2
    }
    
    //MARK: ======Register Tableview XIB======
    func SetUpRegisterNIB(){
        UserMenuTableView.register(UINib(nibName: CellName.UserMenuTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.UserMenuTableViewCell.rawValue)
        UserMenuTableView.register(UINib(nibName: CellName.MenuTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.MenuTableViewCell.rawValue)
        UserMenuTableView.register(UINib(nibName: CellName.MenuLogoutButtonCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.MenuLogoutButtonCell.rawValue)
        UserMenuTableView.register(UINib(nibName: CellName.GeneralCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.GeneralCell.rawValue)
    }
    func GetProfileData(){
//        LoaderManager.showLoader()
//        APIManager.share.UserProfileData { (Result) in
//            LoaderManager.hideLoader()
//            switch Result{
//            case .success(let response):
//                print("Response user profile: \(response)")
//                UserDefaultManager.share.storeModelToUserDefault(userData: response.UserData, key: .UserProfileInfo)
//                break
//            case .failure(let error):
//                print("Response get Profile Detail: \(error.localizedDescription)")
//                self.view.makeToast(error.localizedDescription)
//                break
//            }
//        }
    }
    func GetCardDetail_data(){
//        LoaderManager.showLoader()
//        APIManager.share.GetCardDetail { (Result) in
//            LoaderManager.hideLoader()
//            switch Result{
//            case .success(let response):
//                print(response)
//                self.cardDetail = response
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    @IBAction func ProfileTapped(_ sender: UIControl) {
        let profileVC = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension UserMenuViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1: 
            return 1
        case 2:
            return MenuIcon.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UserMenuTableView.dequeueReusableCell(withIdentifier: CellName.UserMenuTableViewCell.rawValue, for: indexPath) as! UserMenuTableViewCell
            cell.cardDetail = cardDetail
            cell.superVC = self
            return cell
        case 1:
            let GeneralCell = UserMenuTableView.dequeueReusableCell(withIdentifier: CellName.GeneralCell.rawValue, for: indexPath) as! GeneralCell
            return GeneralCell
        case 2:
            let Tablecell = UserMenuTableView.dequeueReusableCell(withIdentifier: CellName.MenuTableViewCell.rawValue, for: indexPath) as! MenuTableViewCell
            Tablecell.MenuImageView.image = MenuIcon[indexPath.row]
            Tablecell.lblMenuName.text = Menuitem[indexPath.row]
            return Tablecell
        case 3:
            let LogoutCell = UserMenuTableView.dequeueReusableCell(withIdentifier: CellName.MenuLogoutButtonCell.rawValue, for: indexPath) as! MenuLogoutButtonCell
            LogoutCell.delegate = self
            return LogoutCell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if indexPath.row == 0{
                let HelpVC = HelpViewController.instantiate(fromAppStoryboard: .Menu)
                navigationController?.pushViewController(HelpVC, animated: true)
            }else if indexPath.row == 1{
                let PrivacypolicyVC = PrivacyPolicyViewController.instantiate(fromAppStoryboard: .Menu)
                navigationController?.pushViewController(PrivacypolicyVC, animated: true)
            }else if indexPath.row == 2{
                let PrivacypolicyVC = PrivacyPolicyViewController.instantiate(fromAppStoryboard: .Menu)
                navigationController?.pushViewController(PrivacypolicyVC, animated: true)
            }else if indexPath.row == 3{
                let AboutusVC = AboutusViewController.instantiate(fromAppStoryboard: .Menu)
                navigationController?.pushViewController(AboutusVC, animated: true)
            }else{
                print("not getting row")
            }
        default:
            break
        }
    }
}
extension UserMenuViewController: LogoutActionDelegate{
    func LogoutTapped() {
        setBoolUserDefaultValue(value: false, key: .isUserLogin)
        UserDefaults.standard.setValue(nil, forKey: "AuthToken")
        UserDefaultManager.share.clearAllUserDataAndModel()
        GIDSignIn.sharedInstance().signOut()
        let loginManager = LoginManager()
        loginManager.logOut()
        let LoginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    
}
