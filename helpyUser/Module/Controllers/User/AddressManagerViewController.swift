//
//  AddressManagerViewController.swift
//  Helpy
//
//  Created by mac on 19/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
protocol EditAddressDelegate {
    func selectedAddressAction(addressID: Int)
}
class AddressManagerViewController: UIViewController {
    
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var AddressTableview: UITableView!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var LblAddress: UILabel!
    
    var userAddressData = [AddressDetails]()
    var deleteResponseArray: UserDetails?
    var selectedIndexPath: Int?
    let editButton = UIButton(type: UIButton.ButtonType.custom)
    let deleteButton = UIButton(type: UIButton.ButtonType.custom)
    var isnewOrder = false
    var isEditAddress = false
    var delegate : EditAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressTableview.register(UINib(nibName: "AddressManagerTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressManagerTableViewCell")
        Set_navigationBar(Title: "Address Manager", isneedback: true)
        AddressTableview.delegate = self
        AddressTableview.dataSource = self
        self.Get_Address_Data()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.Get_Address_Data()
        }
        self.editButton.isHidden = true
        self.deleteButton.isHidden = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        let editBarButton = UIBarButtonItem(customView: editButton)
        editButton.setImage(UIImage(named: ImageName.Edit), for: UIControl.State.normal)
        editButton.addTarget(self, action:#selector(btnEditPressed(_:)), for:.touchUpInside)
        editBarButton.setNavigationBarButtonItemFrame()
        let deleteBarButton = UIBarButtonItem(customView: deleteButton)
        deleteButton.setImage(UIImage(named: ImageName.Delete), for: UIControl.State.normal)
        deleteButton.addTarget(self, action:#selector(btnDeletePressed(_:)), for: .touchUpInside)
        deleteBarButton.setNavigationBarButtonItemFrame()
        self.navigationItem.rightBarButtonItems = [deleteBarButton,editBarButton]
    }
    
    override func viewDidLayoutSubviews() {
        btnLocation.cornerRadius = btnLocation.frame.size.width / 2
    }
    
    func Get_Address_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetUserAddressData { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.userAddressData = response.data ?? [AddressDetails]()
                // print("user main array:\(self.userAddressData)")
                self.AddressTableview.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    func deleteAddress(addressID: String) {
        LoaderManager.showLoader()
        APIManager.share.DeleteAddress(addressID: addressID) { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.userAddressData.remove(at: self.selectedIndexPath ?? 1)
                self.AddressTableview.reloadData()
                self.deleteResponseArray = response
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @objc func btnEditPressed(_ sender: UIButton) {
        let newAddressVC = NewAddressViewController.instantiate(fromAppStoryboard: .Address)
        newAddressVC.addressID = userAddressData[selectedIndexPath ?? 0].id ?? 0
        newAddressVC.isFromEdit = true
        newAddressVC.delegate = self
        navigationController?.pushViewController(newAddressVC, animated: true)
    }
    
    @objc func btnDeletePressed(_ sender: UIButton) {
        let addressID = userAddressData[selectedIndexPath ?? 0].id
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete address?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (handler) in
            self.deleteAddress(addressID: "\(addressID ?? 0)")
            self.AddressTableview.reloadData()
            self.editButton.isHidden = true
            self.deleteButton.isHidden = true
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLocationTapped(_ sender: Any) {
        let newAddressVC = NewAddressViewController.instantiate(fromAppStoryboard: .Address)
        navigationController?.pushViewController(newAddressVC, animated: true)
        // print("selected index:\(selectedIndexPath?.row)")
    }
}
extension AddressManagerViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddressData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = AddressTableview.dequeueReusableCell(withIdentifier: "AddressManagerTableViewCell", for: indexPath) as! AddressManagerTableViewCell
        cell.userAddressObject = self.userAddressData[indexPath.row]
        
        if userAddressData[indexPath.row].isSelect {
            cell.selectImage.image = UIImage(named: ImageName.Check)
        }else {
            cell.selectImage.image = UIImage(named: ImageName.uncheck)
        }
        if userAddressData[indexPath.row].isPrimary == 1{
            cell.primaryLabel.isHidden = false
        }else{
            cell.primaryLabel.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditAddress == true{
            delegate?.selectedAddressAction(addressID: userAddressData[indexPath.row].id ?? 0)
            navigationController?.popViewController(animated: true)
        }else{
            selectedIndexPath = indexPath.row
            for i in 0..<userAddressData.count {
                if i == indexPath.row {
                    if userAddressData[i].isSelect {
                        userAddressData[i].isSelect = false
                        deleteButton.isHidden = true
                        editButton.isHidden = true
                    } else {
                        userAddressData[i].isSelect = true
                    }
                    if let delegate = delegate {
                        if let id = userAddressData[i].id {
                            delegate.selectedAddressAction(addressID: id)
                            navigationController?.popViewController(animated: true)
                        }
                    }
                }else {
                    userAddressData[i].isSelect = false
                }
            }
            AddressTableview.reloadData()
        }
//        if isnewOrder == true{
//            deleteButton.isHidden = true
//            editButton.isHidden = true
//            //navigationController?.popViewController(animated: true)
//        }else{
            deleteButton.isHidden = false
            editButton.isHidden = false
//        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! AddressManagerTableViewCell
        currentCell.selectImage.image = UIImage(named: ImageName.uncheck)
    }
}
extension AddressManagerViewController : NewAddressDelegate{
    func savebuttonAction() {
        self.Get_Address_Data()
    }
    
    
}
