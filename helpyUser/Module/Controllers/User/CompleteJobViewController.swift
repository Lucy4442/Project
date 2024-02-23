//
//  CompleteJobViewController.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class CompleteJobViewController: UIViewController {

    @IBOutlet weak var CompleteJobtableview: UITableView!
    var arrPayment = [PaymentDetail]()
    var UserPaymentData : UserPayment?
    var orderBookingID : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNIB()
        self.Set_navigationBar(Title: "", isneedback: true)
        UserPayment_Data()
    }
    func setUpNIB(){
        CompleteJobtableview.register(UINib(nibName: CompleteJobDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobDetailTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: PaymentDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentDetailTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: ContactTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ContactTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: LocationDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LocationDetailTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: FeedbackDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FeedbackDetailTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: CompleteJobTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompleteJobTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: SendInvoiceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SendInvoiceTableViewCell.identifier)
        CompleteJobtableview.register(UINib(nibName: FeedbackRequestTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FeedbackRequestTableViewCell.identifier)
    }
    func UserPayment_Data(){
        LoaderManager.showLoader()
        APIManager.share.GetUserPayment(OrderID: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.UserPaymentData = response
                self.Set_navigationBar(Title: self.UserPaymentData?.data?.category ?? "", isneedback: true)
                self.PaymentDetailData()
                self.CompleteJobtableview.reloadData()
            case .failure(let error):
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    func PaymentDetailData(){
        arrPayment = [PaymentDetail(title: "Invoice", Detail:UserPaymentData?.data?.invoice, textColor: "App_Navyblue_Color"),
                      PaymentDetail(title: "Product", Detail: "Amount", textColor: "App_Red_Color"),
                      PaymentDetail(title: "Amount Payble", Detail: "$" + String(UserPaymentData?.data?.amountPayble ?? 0), textColor: "App_LightGray_Color"),
                      PaymentDetail(title: "Delivery Charge", Detail: String(UserPaymentData?.data?.deliveryCharge ?? 0), textColor: "App_LightGray_Color"),
                      PaymentDetail(title: "Total (USD)", Detail: "$" + String(UserPaymentData?.data?.totalPrice ?? 0), textColor: "App_Red_Color")]
    }
}
extension CompleteJobViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return arrPayment.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CompleteJobDetailTableViewCell.identifier, for: indexPath) as! CompleteJobDetailTableViewCell
            cell.configurePaymentCell(data: UserPaymentData?.data)
            return cell
        case 1:
           
                let cell = tableView.dequeueReusableCell(withIdentifier: LocationDetailTableViewCell.identifier, for: indexPath) as! LocationDetailTableViewCell
                cell.configurePaymentcell(data: UserPaymentData?.data)
                return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentDetailTableViewCell.identifier, for: indexPath) as! PaymentDetailTableViewCell
            cell.Payment = arrPayment[indexPath.row]
            if indexPath.row == 0 {
                cell.LineView.isHidden = true
            }else if indexPath.row == 1{
                cell.Line.isHidden = false
            }else if indexPath.row == 2{
                cell.LineView.isHidden = true
            }else if indexPath.row == 3{
                cell.LineView.isHidden = false
            }else if indexPath.row == 4{
                cell.Line.isHidden = true
            }else if indexPath.row == 5{
                cell.LineView.isHidden = true
            }
            return cell
        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackDetailTableViewCell.identifier, for: indexPath) as! FeedbackDetailTableViewCell
//            cell.configurePaymentCell(data: UserPaymentData?.data)
//            return cell
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackRequestTableViewCell.identifier, for: indexPath) as! FeedbackRequestTableViewCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: SendInvoiceTableViewCell.identifier, for: indexPath) as! SendInvoiceTableViewCell
            cell.btnSendInvoice.setAttributedTitle(NSAttributedString(string: "Message"), for: .normal)
            cell.btnSendInvoice.setTitleColor(UIColor.white, for: .normal)
            cell.lblCustomize.text = "New Order"
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 3:
            let VC = FeedbackViewController.instantiate(fromAppStoryboard: .Order)
            navigationController?.pushViewController(VC, animated: true)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 50
        case 4:
            return 0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Details"
            return headerView
        case 2:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.setImage(UIImage(named: "ic_Invoice")?.withRenderingMode(.alwaysOriginal), for: .normal)
            headerView.delegate = self
            headerView.lblTitle.text = "Payment Details"
            return headerView
        case 3:
            let headerView: HeaderView = UIView.fromNib()
            headerView.btnViewall.isHidden = true
            headerView.lblTitle.text = "Feedback"
            return headerView
        default:
            return UIView.init()
        }
    }
    
}
extension CompleteJobViewController : SendInvoiceActionDelegate, ButtonActionDelegate{
    func SendInvoiceTapped() {
        let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func CustomizeViewAction() {
        let Vc = UserHomeViewController.instantiate(fromAppStoryboard: .User)
        self.navigationController?.pushViewController(Vc, animated: true)
    }
    
    func ViewAllTapped() {
        let InvoiceVC = InvoiceViewController.instantiate(fromAppStoryboard: .Order)
        InvoiceVC.UrlString = UserPaymentData?.data?.url
        InvoiceVC.orderBookingID = UserPaymentData?.data?.id ?? 0
        self.navigationController?.pushViewController(InvoiceVC, animated: true)
    }
    
//    func CompleteJobTapped() {
//        let homeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
//        self.navigationController?.pushViewController(homeVC, animated: true)
//    }
    
    
}
