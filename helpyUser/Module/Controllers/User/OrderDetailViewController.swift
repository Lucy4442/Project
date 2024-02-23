//
//  OrderDetailViewController.swift
//  Helpy
//
//  Created by mac on 28/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SkyFloatingLabelTextField

class OrderDetailViewController: UIViewController {
    @IBOutlet weak var lblCancelOrder: UILabel!
    
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblreason: UILabel!
    @IBOutlet weak var CancelPopup: UIView!
    @IBOutlet weak var CancelBGView: UIControl!
    @IBOutlet weak var OrderDetailTableView: UITableView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var btnEditOrder: UIButton!
    @IBOutlet weak var btnCancelOrder: UIButton!
    @IBOutlet weak var btnMoreHelp: UIButton!
    @IBOutlet weak var cancelReasonTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var popUpView_height: NSLayoutConstraint!
    
    var orderBookingID : Int = 0
    var bookingDataArray: BookingData?
    var isFromRequest = false
    var isPendingPayment : Bool = false
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        SetupNavigationUI()
        self.Set_navigationBar(Title: "", isneedback: true)
        OrderDetailTableView.delegate = self
        OrderDetailTableView.dataSource = self
        BGView.isHidden = true
        CancelBGView.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFromRequest{
            self.UserOrderDetails()
        }else{
            self.GetBookingDetails()
        }
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewDidLayoutSubviews() {
        PopUpView.roundCorners([.allCorners], radius: 15)
        CancelPopup.roundCorners([.allCorners], radius: 15)
        btnNo.roundCorners([.allCorners], radius: 10)
        btnYes.roundCorners([.allCorners], radius: 10)
    }
    func setUpFont(){
        btnEditOrder.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        btnMoreHelp.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        btnCancelOrder.titleLabel?.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    func setUpNIB() {
        OrderDetailTableView.register(UINib(nibName: OrderDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderDetailTableViewCell.identifier)
        OrderDetailTableView.register(UINib(nibName: OrderCotactTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OrderCotactTableViewCell.identifier)
        OrderDetailTableView.register(UINib(nibName: CompleteJobTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobTableViewCell.identifier)
        OrderDetailTableView.register(UINib(nibName: TrackContactTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrackContactTableViewCell.identifier)
    }
    
    func SetupNavigationUI(){
        let BtnRight = UIButton(type: .custom)
        BtnRight.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        BtnRight.setImage(UIImage(named:"horizonatal"), for: .normal)
        BtnRight.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        let RightBarItem = UIBarButtonItem(customView: BtnRight)
        let rightWidth = RightBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        rightWidth?.isActive = true
        let rightHeight = RightBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        rightHeight?.isActive = true
//        if !isFromRequest {
            self.navigationItem.rightBarButtonItem = RightBarItem
//        }
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
                self.OrderDetailTableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func UserOrderDetails() {
        print("booking id:\(orderBookingID)")
        LoaderManager.showLoader()
        APIManager.share.UserOrderDetails(order_id: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.bookingDataArray = response.data
                self.Set_navigationBar(Title: self.bookingDataArray?.parentCategory ?? "")
                self.OrderDetailTableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @objc func pressed(sender: UIButton!) {
       print("Right navigation button Tapped")
        BGView.isHidden = false
        if isFromRequest == true {
            btnEditOrder.isHidden = true
            btnCancelOrder.isHidden = true
            popUpView_height.constant = 50
        } else {
            btnEditOrder.isHidden = !isPendingPayment
            btnCancelOrder.isHidden = !isPendingPayment
            popUpView_height.constant = isPendingPayment ? 120 : 50
        }
       
    }
    @IBAction func CancelBGTapped(_ sender: UIControl) {
        print("CancelBGView Tapped")
        CancelBGView.isHidden = true
        
    }
    @IBAction func btnNoTapped(_ sender: UIButton) {
        CancelBGView.isHidden = true
    }
    @IBAction func btnYesTapped(_ sender: UIButton) {
        if cancelReasonTextField.text.asStringOrEmpty().isEmpty || cancelReasonTextField.text.asStringOrEmpty().count < 4 {
            AppUtility.alertMessage(enterValidReason, viewcontroller: self)
            return
        }
        CancelBGView.isHidden = true
        self.CancelOrder(orderID: "\(orderBookingID)", reason: cancelReasonTextField.text!)
    }
    
    @IBAction func btnEditOrderTapped(_ sender: UIButton) {
        print("Edit Order")
        self.view.makeToast("work in progress")
        BGView.isHidden = true
        let NewOrderVC = AddNeworderViewController.instantiate(fromAppStoryboard: .User)
        NewOrderVC.orderBookingID = orderBookingID
        NewOrderVC.isUpdateOrder = true
        navigationController?.pushViewController(NewOrderVC, animated: true)
    }
    
    @IBAction func btnCancelOrderTapped(_ sender: UIButton) {
        print("Cancel Order")
        CancelBGView.isHidden = false
    }
    
    @IBAction func btnMoreHelp(_ sender: UIButton){
        print("More Help")
        let HelpVC = HelpViewController.instantiate(fromAppStoryboard: .Menu)
        navigationController?.pushViewController(HelpVC, animated: true)
        BGView.isHidden = true
    }
    @IBAction func BGViewTapeed(_ sender: UIControl) {
        print("BGView Tapped")
        BGView.isHidden = true
    }
    
    func CancelOrder(orderID: String, reason: String) {
        LoaderManager.showLoader()
        APIManager.share.CancelOrder(order_id: orderID, cancel_reason: reason) { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.view.makeToast(response.message)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
                print("error: \(error)")
            }
        }
    }
    
   
}
extension OrderDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFromRequest {
            return 3
        }else {
            return isPendingPayment ? 2 : 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFromRequest {
            switch indexPath.section {
            case 0:
                let cell = OrderDetailTableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
                cell.bookingDetailObject = self.bookingDataArray
                return cell
            case 1:
                let cell = OrderDetailTableView.dequeueReusableCell(withIdentifier: "TrackContactTableViewCell", for: indexPath) as! TrackContactTableViewCell
                cell.ongoingDetail = true
                cell.bookingDetailObject = self.bookingDataArray
                cell.delegate = self
                cell.messageButton.addTarget(self, action: #selector(contactMessageButtonClicked(_:)), for: .touchUpInside)
                cell.callButton.addTarget(self, action: #selector(contactCallButtonClicked(_:)), for: .touchUpInside)
                return cell
            case 2:
                let cell = OrderDetailTableView.dequeueReusableCell(withIdentifier: "CompleteJobTableViewCell", for: indexPath) as! CompleteJobTableViewCell
                cell.btnCompleteJob.setAttributedTitle(NSAttributedString(string: " Complete  Order"), for: .normal)
                cell.btnCompleteJob.setTitleColor(UIColor.white, for: .normal)
                cell.btnCompleteJob.titleLabel?.textAlignment = .center
                cell.btnCompleteJob.titleLabel?.font = UIFont(name: "System", size: 10)
                cell.btnCompleteJob.alpha = bookingDataArray?.status == "Completed" ? 1 : 0
                cell.delegate = self
                return cell
            default:
                return UITableViewCell()
            }
        }else {
            switch indexPath.section {
            case 0:
                let cell = OrderDetailTableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
                cell.bookingDetailObject = self.bookingDataArray
                return cell
            case 1:
                let cell = OrderDetailTableView.dequeueReusableCell(withIdentifier: "CompleteJobTableViewCell", for: indexPath) as! CompleteJobTableViewCell
                cell.btnCompleteJob.setAttributedTitle(NSAttributedString(string: "Pay"), for: .normal)
                cell.btnCompleteJob.setTitleColor(UIColor.white, for: .normal)
                cell.btnCompleteJob.titleLabel?.textAlignment = .center
                cell.btnCompleteJob.titleLabel?.font = UIFont(name: "System", size: 11)
                cell.delegate = self
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc = ContactDetailViewController.instantiate(fromAppStoryboard: .Order)
            vc.orderBookingID = orderBookingID
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func contactMessageButtonClicked(_ sender: UIButton) {
        AppUtility.alertMessage(comingSoonMessage, viewcontroller: self)
    }
    
    @objc func contactCallButtonClicked(_ sender: UIButton) {
        if let mobileNumber = bookingDataArray?.mobile {
            if !CallUtil.call(mobileNumber) {
                AppUtility.alertMessage(someThingWentWrongMessage, viewcontroller: self)
            }
        }
    }
    
}
extension OrderDetailViewController : CompleteJobActionDelegate{
    func CompleteJobTapped() {
        
        if isFromRequest {
            if bookingDataArray?.status == "Completed"{
                let vc = CleaningJobPaymentViewController.instantiate(fromAppStoryboard: .Order)
                vc.orderBookingID = orderBookingID
                navigationController?.pushViewController(vc, animated: true)
            }else{
                self.view.makeToast("Not Enable for Payment")
            }
        }else{
            // pay button Clicked
            moveToPayment(orderBookingID)
        }
       
    }
    
    func moveToPayment(_ orderID: Int) {
        let vc = CleaningJobPaymentViewController.instantiate(fromAppStoryboard: .Order)
        vc.type = .initial
        vc.orderBookingID = orderID
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension OrderDetailViewController: TrackContactTableViewCellDelegate {
    func StoreButtonTapped() {
        print("storeButtonTapped!")
        let Vc = StoreLocationViewController.instantiate(fromAppStoryboard: .Order)
        Vc.ProviderID = orderBookingID
        navigationController?.pushViewController(Vc, animated: true)
    }
}
