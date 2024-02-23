//
//  NewAddressViewController.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
protocol NewAddressDelegate {
    func savebuttonAction()
}
class NewAddressViewController: UIViewController {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var nameLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var pincodeLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var addressLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var landmarkLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var cityLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var stateLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumberLabel: SkyFloatingLabelTextField!
    @IBOutlet weak var primaryAddressButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    
    var newAddressArray: AddressDetails?
    var addressID: Int = 0
    var isFromEdit = false
    var isprimary = 0
    var delegate: NewAddressDelegate?
    
    var selectedLocation : locationPosition? {
        didSet {
            updateMapLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "New Address", isneedback: true)
        setUpMap()
        getAddressDetails {
            if self.isprimary == 1{
                self.primaryAddressButton.setImage(UIImage(named: ImageName.Check), for: .normal)
            }else {
                self.primaryAddressButton.setImage(UIImage(named: ImageName.uncheck), for: .normal)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        btnSave.cornerRadius = btnSave.frame.size.width / 2
    }
    
    @IBAction func primaryAddressButtonPressed() {
        print("primary")
        if isprimary == 0{
            primaryAddressButton.setImage(UIImage(named: ImageName.Check), for: .normal)
            isprimary = 1
        }else {
            primaryAddressButton.setImage(UIImage(named: ImageName.uncheck), for: .normal)
            isprimary = 0
        }
    }
    func isAllDataValid() -> Bool{
        var isValid = true
        if nameLabel.text  == ""{
            isValid = false
            AppUtility.alertMessage(NameEmptyMessage, viewcontroller: self)
        }else if pincodeLabel.text == ""{
            isValid = false
            AppUtility.alertMessage(pincodeEmptyMessage, viewcontroller: self)
        }else if addressLabel.text == ""{
            isValid = false
            AppUtility.alertMessage(AddressEmptyMessage, viewcontroller: self)
        }else if cityLabel.text == ""{
            isValid = false
            AppUtility.alertMessage(CityEmptyMessage, viewcontroller: self)
        }else if stateLabel.text == ""{
            isValid = false
            AppUtility.alertMessage(cardSelectionMessage, viewcontroller: self)
        }else if mobileNumberLabel.text == ""{
            isValid = false
            AppUtility.alertMessage(MobileNoEmptyMessage, viewcontroller: self)
        }else if !AppValidation.isvalidMobileNo(mobileNumberLabel.text ?? ""){
            isValid = false
            AppUtility.alertMessage(MobileNovalidationMessage, viewcontroller: self)
        } else if selectedLocation == nil {
            isValid = false
            AppUtility.alertMessage(PleaseSelectLocationMessage, viewcontroller: self)
        }
        return isValid
    }
    func addNewAddress() {
        if isAllDataValid(){
            LoaderManager.showLoader()
            APIManager.share.AdduserAddress(username: nameLabel.text ?? "", mobile: mobileNumberLabel.text ?? "", address: addressLabel.text ?? "", city: cityLabel.text ?? "", state: stateLabel.text ?? "", landmark: landmarkLabel.text ?? "", pincode: pincodeLabel.text ?? "", is_primary: "\(isprimary)",latitude: (selectedLocation?.latitude).asStringOrEmpty(),longitude: (selectedLocation?.longitude).asStringOrEmpty()) { (Result) in
                LoaderManager.hideLoader()
                switch Result {
                case .success(let response):
                    self.newAddressArray = response.data
                    self.delegate?.savebuttonAction()
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("error: \(error)")
                    AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                }
            }
        }
       
    }
    
    func getAddressDetails(completion: @escaping ()->()) {
        LoaderManager.showLoader()
        APIManager.share.GetAddressDetails(addressID: "\(addressID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.mobileNumberLabel.text = response.data?.mobile ?? CountryCode().getPhoneCodeForCurrentUser().asStringOrEmpty()
                self.addressLabel.text = response.data?.address
                self.cityLabel.text = response.data?.city
                self.isprimary = response.data?.isPrimary ?? 0
                self.landmarkLabel.text = response.data?.landmark
                self.nameLabel.text = response.data?.name
                self.pincodeLabel.text = response.data?.pincode
                self.stateLabel.text = response.data?.state
                if let latitude = Double((response.data?.latitude).asStringOrEmpty()), let longitude = Double((response.data?.longitude).asStringOrEmpty()) {
                    self.selectedLocation = (latitude,longitude)
                }
                completion()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func updateAddress() {
        if isAllDataValid(){
            LoaderManager.showLoader()
            APIManager.share.updateAddress(address_id: addressID, username: self.nameLabel.text ?? "", mobile: self.mobileNumberLabel.text ?? "", address: self.addressLabel.text ?? "", city: self.cityLabel.text ?? "", state: self.stateLabel.text ?? "", pincode: self.pincodeLabel.text ?? "", landmark: self.landmarkLabel.text ?? "", is_primary: "\( self.isprimary)",latitude: (selectedLocation?.latitude).asStringOrEmpty(),longitude: (selectedLocation?.longitude).asStringOrEmpty()) { (Result) in
                LoaderManager.hideLoader()
                switch Result {
                case .success(let response):
                    self.newAddressArray = response.data
                    self.delegate?.savebuttonAction()
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self.view.makeToast(error.localizedDescription)
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
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        if isFromEdit {
            self.updateAddress()
        } else {
            self.addNewAddress()
        }
    }
}



extension NewAddressViewController: LocationDelegate {

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
        self.addressLabel.text = locationAddress.address
        self.pincodeLabel.text = locationAddress.pinCode
        self.landmarkLabel.text = locationAddress.landMark
        self.cityLabel.text = locationAddress.city
        self.stateLabel.text = locationAddress.state
    }
    
}
