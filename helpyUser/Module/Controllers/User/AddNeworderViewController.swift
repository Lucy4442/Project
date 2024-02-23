//
//  AddNeworderViewController.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
enum NewOrderDataList {
    case previousOrder
    case MoreOrder
    case Categories
    case MoreFacilities
    case MoreAddon
    case ScheduleDateTime
    case Address
}
protocol RemoveAddonDelegate: AnyObject {
    func RemoveCheckmark(Object: Addon)
}
class AddNeworderViewController: UIViewController {
    
    @IBOutlet weak var NewOrderTableview: UITableView!
    var previousOrdersArray : PreviousOrders?
    var subSubCategoryArray : ServiceDetail?
    var subCategoryArray : ServiceDetail?
    var mainCategoryObject : ServiceDetail?
    var AddOnArray = [Addon]()
    var selectedTime = ""
    var selectedstartTime : String? = nil
    var selectedtendTime : String? = nil
    var selectedDate : String? = nil
    var RemoveAddon : Bool = false
    var index = 0
    var NewOrderArray = [NewOrderDataList]()
    var Delegate: RemoveAddonDelegate?
    var cartTotal : Int?
    var Labeltype : String?
    var bookingDataArray: BookingData?
    var orderBookingID : Int = 0
    var isUpdateOrder = false
    var userAddressData : AddressDetails?
    var AddressID : Int = 0
    var hasAddonService: Bool? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "New Order", isneedback: true)
        setUpNIB()
        if isUpdateOrder == true{
            self.GetBookingDetails()
            self.GetPreviousOrders()
        }else{
            self.GetPreviousOrders()
        }
        NewOrderTableview.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
         self.GetPreviousOrders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setUpNIB(){
        NewOrderTableview.register(UINib(nibName: CustomOrderCategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomOrderCategoriesTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: ScheduleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScheduleTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: AddAddressTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddAddressTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: OrderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: MoreOptionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MoreOptionTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: UserServiceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserServiceTableViewCell.identifier)
        NewOrderTableview.register(UINib(nibName: NewOrderAddonTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewOrderAddonTableViewCell.identifier)
        addNewOrderData()
    }
    
    func refectorAddOnViewAccroddingSub() {
        let subID = bookingDataArray?.subCategoryId == nil ? bookingDataArray?.parentId ?? 0 : bookingDataArray?.subCategoryId ?? 0
        hasAddOnService(subserviceID: subID.description,completion: nil)
    }
    
    func addNewOrderData(){
        NewOrderArray = []
        if isUpdateOrder == true{
            NewOrderArray.append(.Categories)
            NewOrderArray.append(.MoreFacilities)
            if (self.hasAddonService ?? false) {
                NewOrderArray.append(.MoreAddon)
            }
            NewOrderArray.append(.ScheduleDateTime)
            NewOrderArray.append(.Address)
        }else{
            NewOrderArray.append(.previousOrder)
            NewOrderArray.append(.MoreOrder)
            NewOrderArray.append(.Categories)
            NewOrderArray.append(.MoreFacilities)
            NewOrderArray.append(.MoreAddon)
            NewOrderArray.append(.ScheduleDateTime)
            NewOrderArray.append(.Address)
            if isUpdateOrder == false{
                if AddOnArray.isEmpty{
                        if let index = NewOrderArray.firstIndex(of: .MoreAddon) {
                            NewOrderArray.remove(at: index)
                        }
                    }
            }
        }
        NewOrderTableview.reloadData()
    }
    func GetPreviousOrders() {
        LoaderManager.showLoader()
        APIManager.share.GetPreviousOrders(label: Labeltype ?? "", Cart: String(cartTotal ?? 0)) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.previousOrdersArray = response
                self.NewOrderTableview.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    func getAddressDetails() {
        LoaderManager.showLoader()
        APIManager.share.GetAddressDetails(addressID: "\(AddressID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.bookingDataArray?.address = response.data
                self.previousOrdersArray?.data?.address = Address(address: nil, city: nil, createdAt: nil, deletedAt: nil, id: nil, isPrimary: nil, landmark: nil, mobile: response.data?.mobile, name: response.data?.name, pincode: nil, state: nil, updatedAt: nil, userId: nil)
                self.NewOrderTableview.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    func GetBookingDetails() {
        print("booking id:\(orderBookingID)")
        LoaderManager.showLoader()
        APIManager.share.OrderBookingDetails(booking_id: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.bookingDataArray = response.data
                self.Set_navigationBar(Title: self.bookingDataArray?.parentCategory ?? "")
                self.NewOrderTableview.reloadData()
                self.refectorAddOnViewAccroddingSub()
            case .failure(let error):
                print("error: \(error)")
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    func OrderBooking(job_type: String, parent_id: String, sub_category_id: String, sub_sub_category_id: String, date: String, start_time: String, end_time: String, address_id: String, job_name:  String, job_description:  String ,label_type: String, is_cart:String, addon_id: String) {
        LoaderManager.showLoader()
        APIManager.share.OrderBooking(job_type: job_type, parent_id: parent_id, sub_category_id: sub_category_id, sub_sub_category_id: sub_sub_category_id, date: date, start_time: start_time, end_time: end_time, address_id: address_id, job_name: job_name, job_description: job_description, label_type: label_type, is_cart: is_cart, addon_id: addon_id) { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                print("orderbooking response:\(response)")
                let orderId : Int = (response.data?.id) ?? 0
                self.moveToPayment(orderId)
//                let UserHomeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
//                UserHomeVC.view.makeToast(response.message)
//                self.navigationController?.pushViewController(UserHomeVC, animated: true)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func moveToPayment(_ orderID: Int) {
        let vc = CleaningJobPaymentViewController.instantiate(fromAppStoryboard: .Order)
        vc.type = .initial
        vc.orderBookingID = orderID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func UpdateOrder(addonID: String){
        if selectedDate.asStringOrEmpty().isEmpty {
            self.selectedDate = formateDate((bookingDataArray?.date).asStringOrEmpty(),format: "MM MMMM yyyy") ?? bookingDataArray?.date.asStringOrEmpty()
        }
        APIManager.share.UpdateOrder_Data(order_id: String(orderBookingID), date: selectedDate.asStringOrEmpty() , start_time: selectedstartTime.asStringOrEmpty(), end_time: selectedtendTime.asStringOrEmpty(), address_id: String(AddressID), label_type: self.bookingDataArray?.LabelType ?? "" , is_cart: String(self.bookingDataArray?.categoryIsCart ?? 0), addon_id: addonID) { (Result) in
            switch Result{
            case .success(let response):
                self.view.makeToast(response.message)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension AddNeworderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewOrderArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch NewOrderArray[section] {
        case .previousOrder, .MoreOrder:
            if previousOrdersArray?.data?.order != nil{
                return 1
            }else{
                return 0
            }
        case .MoreFacilities:
            if isUpdateOrder {
                if bookingDataArray?.categoryIsCart ?? 0 == 0{
                    if bookingDataArray?.addons?.count ?? 0 == 0 {
                        return 0
                    }else{
                        return bookingDataArray?.addons?.count ?? 0
                    }
                }else{
                    return 1
                }
            }else{
                if Labeltype == nil{
                    return AddOnArray.count
                }else{
                    return 1
                }
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch NewOrderArray[indexPath.section] {
        case .previousOrder:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
            cell.previousOrderDataObject = self.previousOrdersArray?.data
            return cell
        case .MoreOrder:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: MoreOptionTableViewCell.identifier, for: indexPath) as! MoreOptionTableViewCell
            cell.btnMoreoption.setTitle("More Order", for: .normal)
            cell.moredelegate = self
            return cell
        case .Categories:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: UserServiceTableViewCell.identifier, for: indexPath) as! UserServiceTableViewCell
            if isUpdateOrder == true {
                cell.OrderData = bookingDataArray
                cell.priceLabel.isHidden = false
                cell.priceTitle.isHidden = false
            }else{
                if subCategoryArray ==  nil{
                    cell.subsubObject = self.mainCategoryObject
                    cell.priceLabel.isHidden = false
                    cell.priceTitle.isHidden = false
                }else{
                    cell.subsubObject = self.subCategoryArray
                    cell.priceLabel.isHidden = false
                    cell.priceTitle.isHidden = false
                }
            }
            
            return cell
        case .MoreFacilities:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: NewOrderAddonTableViewCell.identifier, for: indexPath) as! NewOrderAddonTableViewCell
            if isUpdateOrder == true{
                if bookingDataArray?.categoryIsCart != 0{
                    cell.configureiscartCell(data: bookingDataArray)
                }else{
                    cell.btnRemove.isHidden = false
                    cell.delegate = self
                    cell.btnRemove.tag = indexPath.row
                    cell.configureCell(data: bookingDataArray?.addons?[indexPath.row])
                    cell.titleLabel.text = bookingDataArray?.addons?[indexPath.row].addonName
                    cell.PriceLabel.text = "Price: $" + String(bookingDataArray?.addons?[indexPath.row].price ?? 0)
                }
            }else{
                if Labeltype == nil{
                    cell.configureCell(data: AddOnArray[indexPath.row])
                    cell.btnRemove.tag = indexPath.row
                    cell.delegate = self
                }else{
                    cell.PriceLabel.text = "Price: $"+String(previousOrdersArray?.data?.isCartPrice ?? 0)
                    cell.titleLabel.text = Labeltype
                    cell.btnRemove.setTitle(String(cartTotal ?? 0), for: .normal)
                    cell.btnRemove.backgroundColor = .clear
                    cell.btnRemove.setTitleColor(UIColor.App_Gray, for: .normal)
                }
            }
            return cell
        case .MoreAddon:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: MoreOptionTableViewCell.identifier, for: indexPath) as! MoreOptionTableViewCell
            cell.btnMoreoption.setTitle("More Facilities", for: .normal)
            cell.moredelegate = self
            return cell
        case .ScheduleDateTime:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as! ScheduleTableViewCell
            cell.delegate = self
            if isUpdateOrder == true {
                cell.btnPickupTime.isHidden = true
                cell.StartTimeVIew.isHidden = false
                cell.EndTimeView.isHidden = false
                cell.dateView.isHidden = false
                cell.startTime.text = bookingDataArray?.startTime
                cell.endTime.text = bookingDataArray?.endTime
                cell.workDateLabel.text = bookingDataArray?.date.asStringOrEmpty()
                if bookingDataArray?.startTime == nil && bookingDataArray?.endTime == nil && bookingDataArray?.date == nil {
                    cell.refreshTimeView()
                }
            }else{
                if selectedstartTime == nil && selectedtendTime == nil && selectedDate == nil {
                    cell.refreshTimeView()
                } else {
                    cell.StartTimeVIew.isHidden = false
                    cell.EndTimeView.isHidden = false
                    cell.dateView.isHidden = false
                    cell.btnPickupTime.isHidden = true
                }
                cell.startTime.text = selectedstartTime
                cell.endTime.text = selectedtendTime
                cell.workDateLabel.text = selectedDate
            }
            return cell
        case .Address:
            let cell = NewOrderTableview.dequeueReusableCell(withIdentifier: AddAddressTableViewCell.identifier, for: indexPath) as! AddAddressTableViewCell
            if isUpdateOrder == true{
                cell.OrderData = bookingDataArray?.address
            }else{
                cell.addressObject = self.previousOrdersArray?.data?.address
            }
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch NewOrderArray[section] {
        case .Categories,.ScheduleDateTime,.Address:
            return 40
        case .previousOrder, .MoreOrder:
            if previousOrdersArray?.data?.order != nil{
                return 40
            }else{
                return 0
            }
        case .MoreFacilities:
            if Labeltype == nil && AddOnArray.isEmpty{
                return 0
            }else{
                if !AddOnArray.isEmpty{
                    return 40
                }else{
                    return 40
                }
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch NewOrderArray[section] {
        case .previousOrder:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Previous Order"
            return headerView
        case .Categories:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Categories"
            return headerView
        case .MoreFacilities:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            if Labeltype == nil && AddOnArray.isEmpty{
                headerView.lblTitle.text = "More Facilities"
            }else{
                if !AddOnArray.isEmpty{
                    headerView.lblTitle.text = "More Facilities"
                }else{
                    headerView.lblTitle.text = "Added Cart"
                }
                
            }
            return headerView
        case .ScheduleDateTime:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Schedule Date & Time"
            return headerView
        case .Address:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Address"
            return headerView
        default:
            return UIView.init()
        }
    }
}
extension AddNeworderViewController: OrderActionDelegate, ScheduleActionDelegate , SaveActionDelegate, MoreOptionDelegate, AddRemoveButtonDelegate, selectedTimeDelegate{
    func startTime(startTime: String, endTime: String) {
        let ScheduleVC = ScheduleViewController.instantiate(fromAppStoryboard: .User)
        ScheduleVC.delegate = self
        ScheduleVC.startTime = startTime
        ScheduleVC.endTime = endTime
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
    
    func endTime(startTime: String, endTime: String) {
        let ScheduleVC = ScheduleViewController.instantiate(fromAppStoryboard: .User)
        ScheduleVC.startTime = startTime
        ScheduleVC.endTime = endTime
        ScheduleVC.delegate = self
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
    
    func PickupTapped(startTime: UIView, EndTime: UIView,Date: UIView, selectTime: UIButton) {
        let ScheduleVC = ScheduleViewController.instantiate(fromAppStoryboard: .User)
        ScheduleVC.delegate = self
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
    
    func selectedTime(startTime: String, endTime: String, Date: String) {
        selectedstartTime = startTime
        selectedtendTime = endTime
        selectedDate = formateDate(Date) ?? Date
        self.bookingDataArray?.startTime = startTime
        self.bookingDataArray?.endTime = endTime
        self.bookingDataArray?.date = formateDate(Date)
        NewOrderTableview.reloadData()
    }
    
    private func formateDate(_ dateString: String, format: String = "yyyy-MM-dd") -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date: Date = dateFormatterGet.date(from: dateString) {
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func RemoveAction(sender: UIButton) {
        if isUpdateOrder == true{
            var object = bookingDataArray?.addons?[sender.tag]
            object?.isSelected  = false
            Delegate?.RemoveCheckmark(Object: object!)
            bookingDataArray?.addons?.remove(at: sender.tag)
        }else{
            var object = AddOnArray[sender.tag]
            object.isSelected  = false
            Delegate?.RemoveCheckmark(Object: object)
            AddOnArray.remove(at: sender.tag)
        }
        
        NewOrderTableview.reloadData()
    }
    
    func MoreButtonAction(sender: UIButton) {
        if sender.titleLabel?.text == "More Facilities"{
            if isUpdateOrder == true {
                let subID = bookingDataArray?.subCategoryId == nil ? bookingDataArray?.parentId ?? 0 : bookingDataArray?.subCategoryId ?? 0
                hasAddOnService(subserviceID: subID.description) { [weak self] value in
                    guard let `self` = self else { return }
                    if value {
                        let addonVC = AddOnViewController.instantiate(fromAppStoryboard: .User)
                        addonVC.isUpdateOrder = true
                        addonVC.delegate = self
                        if self.bookingDataArray?.subCategoryId == nil{
                            addonVC.subserviceID = self.bookingDataArray?.parentId ?? 0
                        }else{
                            addonVC.subserviceID = self.bookingDataArray?.subCategoryId ?? 0
                        }
                        self.navigationController?.pushViewController(addonVC, animated: true)
                    } else {
                        let cartVC = AddToCartViewController.instantiate(fromAppStoryboard: .User)
                        cartVC.isUpdateCart = true
                        cartVC.delegate = self
                        cartVC.lableType = self.bookingDataArray?.categoryLabelType
                        cartVC.count = self.bookingDataArray?.categoryIsCart ?? 0
                        if self.bookingDataArray?.subCategoryId == nil {
                            cartVC.finalID = (self.bookingDataArray?.parentId ?? 0).description
                        }else{
                            cartVC.finalID = (self.bookingDataArray?.subCategoryId ?? 0).description
                        }
                        self.navigationController?.pushViewController(cartVC, animated: true)
                    }
                }
            }else{
                navigationController?.popViewController(animated: true)
            }
        }else{
            let OrderVC = OrderViewController.instantiate(fromAppStoryboard: .Order)
            navigationController?.pushViewController(OrderVC, animated: true)
        }
    }
    
    func hasAddOnService(subserviceID: String, completion: ((Bool) -> Void)?) {
        guard hasAddonService == nil else {
            completion?(hasAddonService!)
            return
        }
        LoaderManager.showLoader()
        APIManager.share.addOn_Data(service_id: subserviceID) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                let hasService = (response.data?.count ?? 0) != 0
                completion?(hasService)
                self.hasAddonService = hasService
                if hasService {
                    self.bookingDataArray?.categoryIsCart = 0
                }
                self.view.makeToast(response.message)
                self.addNewOrderData()
                self.NewOrderTableview.reloadData()
            case .failure(let error):
                completion?(false)
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func editAddress() {
        if isUpdateOrder == true{
            let UserAddressVC = AddressManagerViewController.instantiate(fromAppStoryboard: .Address)
            UserAddressVC.isEditAddress = true
            UserAddressVC.delegate = self
            UserAddressVC.isnewOrder = true
            navigationController?.pushViewController(UserAddressVC, animated: true)
        }else{
            let UserAddressVC = AddressManagerViewController.instantiate(fromAppStoryboard: .Address)
            UserAddressVC.delegate = self
            UserAddressVC.isnewOrder = true
            navigationController?.pushViewController(UserAddressVC, animated: true)
        }
    }
    func saveTapped() {
        if isUpdateOrder == true{
            self.view.makeToast("Edit Order Detail")
            var AddonID = ""
            for i in 0..<(bookingDataArray?.addons?.count ?? 0) {
                if let data = (bookingDataArray?.addons?[i].categoryAddonId ?? bookingDataArray?.addons?[i].id) {
                    if AddonID.isEmpty{
                        AddonID = String(data)
                    } else {
                        AddonID =   AddonID + "," +  String(data)
                    }
                }
            }
            UpdateOrder(addonID: AddonID)
        }else{
            var AddonID = ""
            for i in 0..<(AddOnArray.count) {
                if let data = AddOnArray[i].id{
                    if AddonID.isEmpty{
                        AddonID = String(data)
                    }else{
                        AddonID =   AddonID + "," +  String(data)
                    }
                }
            }
            print("Addon ID = \(AddonID)")
            OrderBooking(job_type: "1", parent_id: String(mainCategoryObject?.id ?? 0), sub_category_id: String(subCategoryArray?.id ?? 0), sub_sub_category_id: String(subSubCategoryArray?.id ?? 0), date: selectedDate.asStringOrEmpty(), start_time: selectedstartTime.asStringOrEmpty(), end_time: selectedtendTime.asStringOrEmpty(), address_id: String(previousOrdersArray?.data?.address?.id ?? 0), job_name: previousOrdersArray?.data?.order?.jobName ?? "", job_description: previousOrdersArray?.data?.order?.jobDescription ?? "", label_type: Labeltype ?? "", is_cart: String(cartTotal ?? 0), addon_id: AddonID)
        }
            
    }
    
   
    func PreviousOrderTapped() {
        let OrderVC = OrderViewController.instantiate(fromAppStoryboard: .Order)
        navigationController?.pushViewController(OrderVC, animated: true)
    }
    
    func AddCustomOrderTapped() {
        let OrderVC = AddCustomOrderViewController.instantiate(fromAppStoryboard: .User)
        navigationController?.pushViewController(OrderVC, animated: true)
    }
}
extension AddNeworderViewController : EditAddonDelegate, EditCartDelegate, EditAddressDelegate{
    func selectedAddressAction(addressID: Int) {
        AddressID = addressID
        self.getAddressDetails()
    }
    
    func EditCartAction(count: Int) {
        self.bookingDataArray?.categoryIsCart  = count
        NewOrderTableview.reloadData()
    }
    
    func EditAddOnAction(addOnArray: [Addon]) {
        self.bookingDataArray?.addons = addOnArray
        NewOrderTableview.reloadData()
    }
    
}
