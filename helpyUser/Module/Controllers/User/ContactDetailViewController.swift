//
//  ContactDetailViewController.swift
//  helpyUser
//
//  Created by mac on 08/02/21.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ContactDetailTableView: UITableView!
    var providerInfo : ServiceProviderInfo?
    var orderBookingID : Int = 0
    var favoriteData : addFavorite?
    var mobileNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackButton()
        setUpNIB()
        GetServiceProviderInfo(booking_id: String(orderBookingID))
    }
    func setUpNIB() {
        ContactDetailTableView.register(UINib(nibName: BioTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BioTableViewCell.identifier)
        
        ContactDetailTableView.register(UINib(nibName: DestinationLocationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DestinationLocationTableViewCell.identifier)
        
        ContactDetailTableView.register(UINib(nibName: ContactTitleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ContactTitleTableViewCell.identifier)
        
        ContactDetailTableView.register(UINib(nibName: FeedbackDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FeedbackDetailTableViewCell.identifier)
        
        ContactDetailTableView.register(UINib(nibName: SendInvoiceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SendInvoiceTableViewCell.identifier)
    }
    func GetServiceProviderInfo(booking_id: String) {
        LoaderManager.showLoader()
        APIManager.share.GetServiceProviderInfo(booking_id: booking_id) { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.providerInfo = response
                self.mobileNumber = response.data?.mobile ?? ""
                self.Set_navigationBar(Title: response.data?.name ?? "", isneedback: true)
                self.ContactDetailTableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
            }
        }
    }
    func addFavoriteData(button: UIButton){
        LoaderManager.showLoader()
        APIManager.share.addFavoriteData(provider_id: "\(orderBookingID)") { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                self.favoriteData = response
                if self.favoriteData?.data?.isBookmark == 1{
                    button.setImage(UIImage(named: ImageName.selectedFavorite), for: .normal)
                    self.view.makeToast("Add favorite successfully")
                } else {
                    button.setImage(UIImage(named: ImageName.favoritelist), for: .normal)
                    self.view.makeToast("Remove favorite successfully")
                }
                self.ContactDetailTableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}
extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return providerInfo?.data?.review?.count ?? 0
        default:
            return 1
        }
       // return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = ContactDetailTableView.dequeueReusableCell(withIdentifier: ContactTitleTableViewCell.identifier, for: indexPath) as! ContactTitleTableViewCell
            cell.providerInfo = providerInfo?.data
            cell.delegate = self
            return cell
        case 1:
            let cell = ContactDetailTableView.dequeueReusableCell(withIdentifier: BioTableViewCell.identifier, for: indexPath) as! BioTableViewCell
            cell.providerInfo = providerInfo?.data
            return cell
        case 2:
            let cell = ContactDetailTableView.dequeueReusableCell(withIdentifier: DestinationLocationTableViewCell.identifier, for: indexPath) as! DestinationLocationTableViewCell
            cell.providerInfo = providerInfo?.data
            return cell
        case 3:
            let cell = ContactDetailTableView.dequeueReusableCell(withIdentifier: FeedbackDetailTableViewCell.identifier, for: indexPath) as! FeedbackDetailTableViewCell
            cell.ReviewData = providerInfo?.data?.review?[indexPath.row]
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: SendInvoiceTableViewCell.identifier, for: indexPath) as! SendInvoiceTableViewCell
            cell.btnSendInvoice.setAttributedTitle(NSAttributedString(string: "Call"), for: .normal)
            cell.btnSendInvoice.addTarget(self, action: #selector(contactCallButtonClicked(_:)), for: .touchUpInside)
            cell.btnSendInvoice.setTitleColor(UIColor.white, for: .normal)
            cell.lblCustomize.text = "Message"
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 50
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView: HeaderView = UIView.fromNib()
            headerView.lblTitle.text = "Bio"
            headerView.btnViewall.isHidden = true
            return headerView
        case 2:
            let headerView: HeaderView = UIView.fromNib()
            headerView.lblTitle.text = "Location"
            headerView.btnViewall.isHidden = true
            return headerView
        case 3:
            let headerView: HeaderView = UIView.fromNib()
            headerView.lblTitle.text = "Reviews"
            headerView.btnViewall.isHidden = true
            return headerView
        case 4:
            let headerView: HeaderView = UIView.fromNib()
            headerView.lblTitle.isHidden = true
            headerView.btnArrow.isHidden = true
            headerView.btnViewall.setTitle("More Review", for: .normal)
            headerView.btnViewall.setTitleColor(.red, for: .normal)
            return headerView
        default:
            return UIView.init()
        }
    }
    
    @objc func contactCallButtonClicked(_ sender: UIButton) {
        if let mobileNumber = providerInfo?.data?.mobile {
            if !CallUtil.call(mobileNumber) {
                AppUtility.alertMessage(someThingWentWrongMessage, viewcontroller: self)
            }
        }
    }
}
extension ContactDetailViewController : SendInvoiceActionDelegate, favoritebuttonDelegate{
    func SendInvoiceTapped() {
        guard let number = URL(string: "tel://" + mobileNumber) else { return }
        UIApplication.shared.open(number)
       // self.view.makeToast("Under Development")
    }
    
    func CustomizeViewAction() {
        self.view.makeToast("Under Development")
    }
    
    func favoriteAction(button: UIButton) {
        addFavoriteData(button: button)
    }
    
}
