//
//  UserServiceViewController.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
protocol subServiceBackDelegate {
    func viewallAction()
}
class UserServiceViewController: UIViewController {
    
    @IBOutlet weak var ServicetableView: UITableView!
    var finalID: String = ""
    var subServiceData : ParentServices?
    var parentServiceData  : ServiceDetail?
    var superVC: UIViewController?
    var sectionIndex: Int = 0
    var rowIndex: Int = 0
    var delegate: subServiceBackDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Get_SubServices_Data()
        Set_navigationBar(Title: parentServiceData?.name ?? "Cleaning Service", isneedback: true)
    }
    @objc func BackTapped(sender: UIBarButtonItem){
        delegate?.viewallAction()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    func setUpNIB(){
        ServicetableView.register(UINib(nibName: "UserServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "UserServiceTableViewCell")
    }
    func Get_SubServices_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetSubServiceData(serviceID: finalID ) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.subServiceData = response
                self.ServicetableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
extension UserServiceViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return subServiceData?.Servicedata?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subServiceData?.Servicedata?[section].subcategory?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return view.frame.height * 0.15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ServicetableView.dequeueReusableCell(withIdentifier: "UserServiceTableViewCell", for: indexPath) as! UserServiceTableViewCell
        cell.ConfigureCell(data: subServiceData?.Servicedata?[indexPath.section].subcategory?[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let UserServiceVC = UserServiceSubCategoryViewController.instantiate(fromAppStoryboard: .User)
        sectionIndex = indexPath.section
        rowIndex = indexPath.row
        let subsubCategoryArray = subServiceData?.Servicedata?[sectionIndex].subcategory?[rowIndex].subsubcategory
        UserServiceVC.mainCategoryArray = self.subServiceData?.Servicedata ?? [ServiceDetail]()
        if let sub_subCategory = subsubCategoryArray {
            if subsubCategoryArray?.isEmpty ?? false{
                if !(subServiceData?.Servicedata?[sectionIndex].subcategory?[rowIndex].addons?.isEmpty ?? false){
                    let AddonVC = AddOnViewController.instantiate(fromAppStoryboard: .User)
                    AddonVC.AddOnArray = self.subServiceData?.Servicedata?[sectionIndex].subcategory?[rowIndex].addons ?? [Addon]()
                    AddonVC.mainCategoryArray = parentServiceData
                    AddonVC.subSubCategoryArray  = subServiceData?.Servicedata?[sectionIndex].subcategory?[rowIndex]
                    navigationController?.pushViewController(AddonVC, animated: true)
                }else{
                    let AddVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
                    AddVC.subSubCategoryArray = subServiceData?.Servicedata?[sectionIndex].subsubcategory?[rowIndex]
                    AddVC.subCategoryArray = subServiceData?.Servicedata?[sectionIndex].subcategory?[rowIndex]
                    AddVC.mainCategoryObject = parentServiceData
                    self.navigationController?.pushViewController(AddVC, animated: true)
                }
                
                
            }else{
                UserServiceVC.subSubCategoryArray = sub_subCategory
                self.navigationController?.pushViewController(UserServiceVC, animated: true)
            }
        }else {
            AppUtility.alertMessage("subsubService", viewcontroller: self)
        }
        
    }
}



