//
//  PaymentmethodViewController.swift
//  helpyUser
//
//  Created by mac on 05/01/21.
//

import UIKit

class PaymentmethodViewController: UIViewController {
    @IBOutlet weak var btnAddnew: UIButton!
    @IBOutlet weak var paymentmethodtableView: UITableView!
    let editButton = UIButton(type: UIButton.ButtonType.custom)
    let deleteButton = UIButton(type: UIButton.ButtonType.custom)
    var CardsDetail = [CardDetail]()
    var selectedIndexPath: Int?
    var Pay : Bool = false
    var orderID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNIB()
        Set_navigationBar(Title: "Payment Method", isneedback: true)
//        GetCardDetail_data()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        GetCardDetail_data()
       // self.paymentmethodtableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       //self.setGradient_Nav(Title: "Payment Method", isneedback: true)
    }
    override func viewDidLayoutSubviews() {
        btnAddnew.cornerRadius = btnAddnew.frame.size.width / 2
    }
    func setUpNIB(){
        paymentmethodtableView.register(UINib(nibName: PaymentMethodTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentMethodTableViewCell.identifier)
    }
    func GetCardDetail_data(){
        //LoaderManager.showLoader()
//        APIManager.share.GetCardDetail { (Result) in
//            LoaderManager.hideLoader()
//            switch Result{
//            case .success(let response):
//                print(response)
//                self.CardsDetail = response.data ?? [CardDetail]()
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                    self.paymentmethodtableView.reloadData()
//                }
//            case .failure(let error):
//                AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
//            }
//        }
    }
    
    func GoToPaymentScreen() {
        if self.Pay == true {
            let newpaymentVC = AddNewPaymentViewController.instantiate(fromAppStoryboard: .Payment)
            newpaymentVC.CardID = self.CardsDetail[self.selectedIndexPath ?? 0].id ?? 0
            newpaymentVC.Pay = self.Pay
            newpaymentVC.orderID = self.orderID
            let selectedCard = CardsDetail[selectedIndexPath ?? 0]
            newpaymentVC.payCardData = .init(name: selectedCard.holderName, cardNumber: selectedCard.cardNo, cvv: "***", expireDate: "\(selectedCard.month.asStringOrEmpty())/\(selectedCard.year.asStringOrEmpty())")
            self.navigationController?.pushViewController(newpaymentVC, animated: true)
        }
    }
    
    func DeleteCardDetail(cardId: String){
        LoaderManager.showLoader()
        APIManager.share.DeleteCard(cardID: cardId) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print(response)
                //self.paymentmethodtableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    @objc func btnEditPressed(_ sender: UIButton) {
        let newpaymentVC = AddNewPaymentViewController.instantiate(fromAppStoryboard: .Payment)
        newpaymentVC.CardID = CardsDetail[selectedIndexPath ?? 0].id ?? 0
        newpaymentVC.isFromEdit = true
        navigationController?.pushViewController(newpaymentVC, animated: true)
    }
    
    @objc func btnDeletePressed(_ sender: UIButton) {
        let cardID = CardsDetail[selectedIndexPath ?? 0].id
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete Card?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (handler) in
            self.DeleteCardDetail(cardId: String(cardID ?? 0))
            self.CardsDetail.remove(at: self.selectedIndexPath ?? 1)
            self.paymentmethodtableView.reloadData()
            self.editButton.isHidden = true
            self.deleteButton.isHidden = true
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func AddNewTapped(_ sender: UIButton) {
        print("Add new tapped...")
        let AddNewPaymentVC = AddNewPaymentViewController.instantiate(fromAppStoryboard: .Payment)
        AddNewPaymentVC.isFirsttime = false
        navigationController?.pushViewController(AddNewPaymentVC, animated: true)
    }
}
extension PaymentmethodViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardsDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = paymentmethodtableView.dequeueReusableCell(withIdentifier: PaymentMethodTableViewCell.identifier, for: indexPath) as! PaymentMethodTableViewCell
        cell.configureCell(data: CardsDetail[indexPath.row])
        if CardsDetail[indexPath.row].isSelect {
            cell.imgcheck.image = UIImage(named: ImageName.Check)
        }else {
            cell.imgcheck.image = UIImage(named: ImageName.uncheck)
        }
        if CardsDetail[indexPath.row].paymentType == 1{
            cell.CardBG.image = UIImage(named: ImageName.debitCardBG)
            cell.lblCardType.text = "Debit Card"
        }else{
            cell.CardBG.image = UIImage(named: ImageName.creditCardBG)
            cell.lblCardType.text = "Credit Card"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteButton.isHidden = Pay
        editButton.isHidden = Pay
        GoToPaymentScreen()
        selectedIndexPath = indexPath.row
        for i in 0..<CardsDetail.count{
            if i == indexPath.row {
                if CardsDetail[i].isSelect {
                    CardsDetail[i].isSelect = false
                    deleteButton.isHidden = true
                    editButton.isHidden = true
                }else {
                    CardsDetail[i].isSelect = true
                }
            }else {
                CardsDetail[i].isSelect = false
            }
        }
        paymentmethodtableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! PaymentMethodTableViewCell
        currentCell.imgcheck.image = UIImage(named: ImageName.uncheck)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
