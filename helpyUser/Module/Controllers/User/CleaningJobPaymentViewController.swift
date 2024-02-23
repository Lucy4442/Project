//
//  CleaningJobPaymentViewController.swift
//  Helpy
//
//  Created by mac on 16/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CleaningJobPaymentViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var PaymentDetailTableView: UITableView!
    
    
    
    var Customize : Bool = false
    var arrPayment = [PaymentDetail]()
    
    var customizeProductName : String?
    var CustomizeAmount : String?
    var orderBookingID : Int = 0
    
    var UserPaymentData : UserPayment?
    var OrderPaymentData : OrderPayment?
    
    var type: PaymentType = .post
    
    enum PaymentType {
        case initial
        case post
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        SetUpRegisterNIB()
        Set_navigationBar(Title: "Payment - House Cleaning", isneedback: true)
        setUpComponents()
    }
    
    private func setUpComponents() {
        switch type {
        case .initial:
            self.OrderPayment_Data()
        case .post:
            self.UserPayment_Data()
        }
    }
    
    func SetUpRegisterNIB() {
        PaymentDetailTableView.register(UINib(nibName: PaymentDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentDetailTableViewCell.identifier)
        PaymentDetailTableView.register(UINib(nibName: ContactTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ContactTableViewCell.identifier)
        PaymentDetailTableView.register(UINib(nibName: SendInvoiceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SendInvoiceTableViewCell.identifier)
        PaymentDetailTableView.register(UINib(nibName: CustomizePaymentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomizePaymentTableViewCell.identifier)
        PaymentDetailTableView.register(UINib(nibName: CompleteJobTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobTableViewCell.identifier)
        PaymentDetailTableView.register(UINib(nibName: CompleteJobDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobDetailTableViewCell.identifier)
    }
    
    func UserPayment_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetUserPayment(OrderID: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.UserPaymentData = response
                self.ArrayInitialization()
                if let catName = self.UserPaymentData?.data?.category {
                    self.Set_navigationBar(Title: "Payment - \(catName)", isneedback: true)
                }
                self.PaymentDetailTableView.reloadData()
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    
    func OrderPayment_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetOrderPayment(OrderID: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.OrderPaymentData = response
                self.ArrayInitialization()
                if let catName = self.OrderPaymentData?.data?.categoryName {
                    self.Set_navigationBar(Title: "Payment - \(catName)", isneedback: true)
                }
                self.PaymentDetailTableView.reloadData()
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    
    func ArrayInitialization() {
        switch type {
        case .initial:
            self.arrPayment = [PaymentDetail(title: "Invoice", Detail: self.OrderPaymentData?.data?.invoice, textColor: "App_Navyblue_Color"),
                               PaymentDetail(title: "Bill to", Detail: self.OrderPaymentData?.data?.categoryName, textColor: "App_Navyblue_Color"),
                               PaymentDetail(title: "Total (USD)", Detail: "$" + String(OrderPaymentData?.data?.totalPrice ?? 0), textColor: "App_Red_Color")]
        case .post:
            self.arrPayment = [PaymentDetail(title: "Invoice", Detail: self.UserPaymentData?.data?.invoice, textColor: "App_Navyblue_Color"),
                               PaymentDetail(title: "Bill to", Detail: self.UserPaymentData?.data?.category, textColor: "App_Navyblue_Color"),
                               PaymentDetail(title: "Product", Detail: "Amount", textColor: "App_Red_Color"),
                               PaymentDetail(title: "Amount Payble", Detail: String(UserPaymentData?.data?.amountPayble ?? 0), textColor: "App_LightGray_Color"),
                               PaymentDetail(title: "Delivery Charge", Detail: String(UserPaymentData?.data?.deliveryCharge ?? 0), textColor: "App_LightGray_Color"),
                               PaymentDetail(title: "Total (USD)", Detail: "$" + String(UserPaymentData?.data?.totalPrice ?? 0), textColor: "App_Red_Color")]
        }
    }
    
}
extension CleaningJobPaymentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Customize ? 5: 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Customize {
            switch section {
            case 0:
                return 1
            case 1:
                return arrPayment.count
            case 2,3,4:
                return 1
            default:
                return 0
            }
        } else {
            switch section {
            case 0:
                return 1
            case 1:
                return arrPayment.count
            case 2:
                return 1
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CompleteJobDetailTableViewCell.identifier, for: indexPath) as! CompleteJobDetailTableViewCell
            switch type {
            case .initial:
                cell.configurePaymentCell(data: OrderPaymentData?.data)
            case .post:
                cell.configurePaymentCell(data: UserPaymentData?.data)
            }
            return cell
        case 1:
            let cell = PaymentDetailTableView.dequeueReusableCell(withIdentifier: PaymentDetailTableViewCell.identifier, for: indexPath) as! PaymentDetailTableViewCell
            cell.Payment = arrPayment[indexPath.row]
            if indexPath.row == 0 {
                cell.LineView.isHidden = true
            }else if indexPath.row == 1{
                cell.LineView.isHidden = true
            }else if indexPath.row == 2{
                cell.LineView.isHidden = false
            }else if indexPath.row == 3{
                cell.LineView.isHidden = true
            }else if indexPath.row == 4{
                cell.LineView.isHidden = false
            }else if indexPath.row == 5{
                cell.LineView.isHidden = true
            }else if indexPath.row == 6{
                cell.LineView.isHidden = false
            }
            return cell
        case 2:
            let cell = PaymentDetailTableView.dequeueReusableCell(withIdentifier: SendInvoiceTableViewCell.identifier, for: indexPath) as! SendInvoiceTableViewCell
            let myNormalAttributedTitle = NSAttributedString(string: "PAY",
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            cell.btnSendInvoice.setAttributedTitle(myNormalAttributedTitle, for: .normal)
            cell.CustomizeView.backgroundColor = .clear
            cell.lblCustomize.isHidden = true
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerview = AppUtility.SetupHeaderview(Frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50), Headername: "Payment Method")
            return headerview
        case 2:
            let headerview = AppUtility.SetupHeaderview(Frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50), Headername: "Payment")
            return headerview
        default:
            return UIView()
        }
    }
    
}
extension CleaningJobPaymentViewController: SendInvoiceActionDelegate, CompleteJobActionDelegate {
    
    func CompleteJobTapped() {
        ArrayInitialization()
        PaymentDetailTableView.reloadData()
    }
    
    func CustomizeViewAction() {
        Customize = true
        ArrayInitialization()
        PaymentDetailTableView.reloadData()
        
    }
    
    func SendInvoiceTapped() {
        let paymentMethodVC = PaymentmethodViewController.instantiate(fromAppStoryboard: .Payment)
        paymentMethodVC.Pay = true
        paymentMethodVC.orderID = orderBookingID
        navigationController?.pushViewController(paymentMethodVC, animated: true)
    }
    
    
}
extension CleaningJobPaymentViewController : AddCustomeDelegate{
    func AddAction(name: String, Amount: String) {
        customizeProductName = name
        CustomizeAmount = Amount
        Customize = false
        ArrayInitialization()
        self.PaymentDetailTableView.reloadData()
    }
}
