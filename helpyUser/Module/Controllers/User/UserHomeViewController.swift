//
//  UserHomeViewController.swift
//  Helpy
//
//  Created by mac on 17/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UserHomeViewController: UIViewController {
    
    //MARK: ==========Outlet==========
    @IBOutlet weak var HomeTableview: UITableView!
    @IBOutlet weak var btnNewOrder: UIButton!
    var finalID: String = ""
    var viewAllTapped = false
    var parentServicesData : ParentServices?
    var UserName = ""
    var FilterparentServiceData: ParentServices?
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNIB()
        viewAllTapped = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.isSetNavigationBar {
            appDelegate.isSetNavigationBar = false
            setnavigationBar()
        }
        if let name = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserData.self, key: .ProfileInfo)?.name {
            UserName = name
        }else{
            UserName = UserDefaultManager.share.getModelDataFromUserDefults(userData: LoginData.self, key: .LoginInfo)?.user?.name ?? ""
        }
//        Get_ParentService_Data()
//        setUpPullToRefresh()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        Set_navigationBar(Title: UserName)
        SetupNavigationUI(rightbarbutton: true)
        reloadHome()
    }
    override func viewWillDisappear(_ animated: Bool) {
        HomeTableview.reloadSections(IndexSet(integer: 1), with: .none)
    }
    func setnavigationBar(){
        if viewAllTapped == true{
            SetupNavigationUI()
        }else{
            setGradient_Nav()
            Set_navigationBar(Title: UserName)
            SetupNavigationUI(rightbarbutton: true)
        }
    }
    func setupNIB(){
        HomeTableview.register(UINib(nibName: CellName.BannerTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellName.BannerTableViewCell.rawValue)
        HomeTableview.register(UINib(nibName: SearchOrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchOrderTableViewCell.identifier)
        HomeTableview.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        HomeTableview.tableFooterView = UIView()
        HomeTableview.separatorStyle = .none
    }
    func Get_ParentService_Data(_ isRefreshing: Bool = false){
        if !isRefreshing {
            LoaderManager.showLoader()
        }
        APIManager.share.GetParentServicesData { (Result) in
            switch Result{
            case .success(let response):
                self.parentServicesData = response
                self.FilterparentServiceData = response
            case .failure(let error):
                print("Error: \(error)")
                self.view.makeToast(error.localizedDescription)
            }
            self.HomeTableview.reloadData()
            self.refreshControl.endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.reloadHome()
                LoaderManager.hideLoader()
            }
        }
    }
    func SetupNavigationUI(rightbarbutton: Bool? = false){
        if(rightbarbutton == true){
            let BtnLeft = UIButton(type: .custom)
            BtnLeft.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
            let profileimage = UserDefaults.standard.string(forKey:"Profile") ?? ""
            if profileimage == ""{
                BtnLeft.setImage(UIImage(named:  ImageName.Userplaceholder), for: .normal)
            }else{
                showActivityIndicator(uiView: BtnLeft)
                BtnLeft.sd_setImage(with: URL(string: profileimage), for: .normal) { (profile, error, type, url) in
                    hideActivityIndicator(uiView: BtnLeft)
                }
            }
            BtnLeft.cornerRadius = BtnLeft.frame.size.width / 2
            BtnLeft.maskToBounds = true
            BtnLeft.borderWidth = 1
            BtnLeft.borderColor = .white
            BtnLeft.addTarget(self, action: #selector(ProfileTapped), for: .touchUpInside)
            let LeftBarItem = UIBarButtonItem(customView: BtnLeft)
            let leftWidth = LeftBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
            leftWidth?.isActive = true
            let LeftHeight = LeftBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
            LeftHeight?.isActive = true
            self.navigationItem.leftBarButtonItem = LeftBarItem
            
            let BtnRight = UIButton(type: .custom)
            BtnRight.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
            BtnRight.setImage(UIImage(named:"Message"), for: .normal)
            BtnRight.addTarget(self, action: #selector(messageButtonClicked(_:)), for: .touchUpInside)
            let RightBarItem = UIBarButtonItem(customView: BtnRight)
            let rightWidth = RightBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
            rightWidth?.isActive = true
            let rightHeight = RightBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
            rightHeight?.isActive = true
            self.navigationItem.rightBarButtonItem = RightBarItem
        }else{
            Set_navigationBar(Title: "Categories")
            self.navigationItem.rightBarButtonItem = nil
            let btnback = UIBarButtonItem(image: UIImage(named: ImageName.back), style: .plain, target: self, action: #selector(BackTapped(sender:)))
            self.navigationItem.leftBarButtonItem  = btnback
        }
    }
    
    @objc func messageButtonClicked(_ sender: UIButton) {
        AppUtility.alertMessage(comingSoonMessage, viewcontroller: self)
    }
    
    @objc func BackTapped(sender: UIBarButtonItem){
        viewAllTapped = false
        btnNewOrder.isHidden = false
        setnavigationBar()
        HomeTableview.reloadData()
    }
    @objc func ProfileTapped() {
        print("profile tapped")
        let MenuVC = UserMenuViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(MenuVC, animated: true)
    }
    
    func reloadHome() {
        parentServicesData?.Servicedata = FilterparentServiceData?.Servicedata
        HomeTableview.reloadSections(IndexSet(integer: 2), with: .none)
        clearSearchBar()
    }
    
    func clearSearchBar() {
        if let searchBarCell = tableView(HomeTableview, cellForRowAt: IndexPath(item: 0, section: 1)) as? SearchOrderTableViewCell {
            searchBarCell.txtSearch.text = ""
        }
    }
    
    func setUpPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Updating...")
        refreshControl.addTarget(self, action: #selector(self.refreshTableView(_:)), for: .valueChanged)
        HomeTableview.addSubview(refreshControl)
    }
    
    @objc func refreshTableView(_ sender: AnyObject) {
       Get_ParentService_Data(true)
    }

    @IBAction func NewOrderTapped(_ sender: Any) {
        print("Neworder Tapped")
        let NewOrderVC = CategoryViewController.instantiate(fromAppStoryboard: .User)
        NewOrderVC.parentServicesData = self.parentServicesData
        navigationController?.pushViewController(NewOrderVC, animated: true)
    }
}
extension UserHomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewAllTapped == true{
            return 1
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewAllTapped == true{
            let cell = HomeTableview.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
            cell.superVC = self
            return cell
            
        }else{
            switch indexPath.section {
            case 0:
                let cell = HomeTableview.dequeueReusableCell(withIdentifier: CellName.BannerTableViewCell.rawValue, for: indexPath) as! BannerTableViewCell
                return cell
            case 1:
                let cell = HomeTableview.dequeueReusableCell(withIdentifier: "SearchOrderTableViewCell", for: indexPath) as! SearchOrderTableViewCell
                cell.delegate = self
                return cell
            case 2:
                let cell = HomeTableview.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
                cell.parentServicesData = parentServicesData
                cell.finalID = finalID
                cell.superVC = self
                cell.Deleagte = self
                cell.reload()
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 2) {
            return 800
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewAllTapped == true{
            return 0
        }else{
            switch section {
            case 0:
                return 0
            case 2:
                return 50
            default:
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewAllTapped == true{
            return UIView()
        }else{
            switch section {
            case 2:
                let headerView: HeaderView = UIView.fromNib()
                headerView.lblTitle.text = "Categories"
                headerView.delegate = self
                return headerView
            default:
                return UIView.init()
            }
        }
    }
}
extension UserHomeViewController : ButtonActionDelegate, CategoriesDelegate, subServiceBackDelegate{
    func viewallAction() {
        viewAllTapped = false
        btnNewOrder.isHidden = false
        setnavigationBar()
        HomeTableview.reloadData()
    }
    
    func CategoriesAction(index: IndexPath, ID: String) {
        
        if parentServicesData?.Servicedata?[index.row].isCart == 2{
            if parentServicesData?.Servicedata?[index.row].cat_type == 0{
                if parentServicesData?.Servicedata?[index.row].addons?.count == 0{
                    let AddVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
                    AddVC.mainCategoryObject = self.parentServicesData?.Servicedata?[index.row]
                    self.navigationController?.pushViewController(AddVC, animated: true)
                }else{
                    let AddonVC = AddOnViewController.instantiate(fromAppStoryboard: .User)
                    AddonVC.AddOnArray = self.parentServicesData?.Servicedata?[index.row].addons ?? [Addon]()
                    AddonVC.ParentSection = index.row
                    AddonVC.mainCategoryArray = self.parentServicesData?.Servicedata?[index.row]
                    navigationController?.pushViewController(AddonVC, animated: true)
                }
            }else{
                let UserServiceVC = UserServiceViewController.instantiate(fromAppStoryboard: .User)
                UserServiceVC.finalID = ID
                UserServiceVC.parentServiceData = self.parentServicesData?.Servicedata?[index.row]
                UserServiceVC.delegate = self
                navigationController?.pushViewController(UserServiceVC, animated: true)
            }
        }else{
            let AddtoCartVC = AddToCartViewController.instantiate(fromAppStoryboard: .User)
            AddtoCartVC.finalID = ID
            AddtoCartVC.mainCategoryArray = self.parentServicesData?.Servicedata?[index.row]
            navigationController?.pushViewController(AddtoCartVC, animated: true)
        }
    }
    
    func ViewAllTapped() {
        let NewOrderVC = CategoryViewController.instantiate(fromAppStoryboard: .User)
        NewOrderVC.parentServicesData = self.parentServicesData
        navigationController?.pushViewController(NewOrderVC, animated: false)
    }
    
}
extension UserHomeViewController: SearchDelegate{
    func SearchCategory(text: String) {
        //
        if text.isEmpty{
            parentServicesData?.Servicedata = FilterparentServiceData?.Servicedata
        }else {
            if let filterData = FilterparentServiceData?.Servicedata {
                parentServicesData?.Servicedata?.removeAll()
                for objectServiceData in filterData {
                    let isMachingWorker : NSString = (objectServiceData.name ?? "") as NSString
                    let range = isMachingWorker.lowercased.range(of: text, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        parentServicesData?.Servicedata?.append(objectServiceData)
                    }
                }
                
            }
        }
        HomeTableview.reloadSections(IndexSet(integer: 2), with: .none)
    }
}
