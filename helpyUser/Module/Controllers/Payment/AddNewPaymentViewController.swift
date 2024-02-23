//
//  AddNewPaymentViewController.swift
//  helpyUser
//
//  Created by mac on 05/01/21.
//

import UIKit
import FormTextField

class AddNewPaymentViewController: UIViewController {
    @IBOutlet weak var paymentmethodLabel: UILabel!
    
    @IBOutlet weak var lblprimarycard: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtCardNumber: FormTextField!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var PaymentmethodCollectionView: UICollectionView!
    @IBOutlet weak var txtexpireDate: FormTextField!
    @IBOutlet weak var imgcvv: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblCardHolderName: UILabel!
    @IBOutlet weak var lblExpiredate: UILabel!
    @IBOutlet weak var lblCVV: UILabel!
    @IBOutlet weak var cardNumberView: UIView!
    @IBOutlet weak var CVVview: UIView!
    @IBOutlet weak var cardHoldernameView: UIView!
    @IBOutlet weak var txtcardHolderName: UITextField!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var txtCVV: FormTextField!
    @IBOutlet weak var imgExpiredate: UIImageView!
    @IBOutlet weak var expiredateView: UIView!
    var validation = Validation()
    var CardID: Int = 0
    var isFromEdit = false
    var isprimary = 0
    var paymentType = 1
    var selectedIndex: Int?
    var cardDetail : CardDetail?
    var cardSelect: Bool = false
    var Pay: Bool = false
    var isFirsttime = false
    var orderID: Int = 0
    
    var payCardData : CardData?
    
    struct CardData {
        let name : String?
        let cardNumber : String?
        let cvv : String?
        let expireDate : String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PaymentmethodCollectionView.delegate = self
        PaymentmethodCollectionView.dataSource = self
        setUpNIB()
        SetupFont()
        Set_navigationBar(Title: "Add New Payment Method", isneedback: true)
        cardNumberField(textfield: txtCardNumber)
        cardExpirationDateField(textField: txtexpireDate)
        cvcField(textField: txtCVV)
        if Pay == true{
            btnSave.setTitle("PAY", for: .normal)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //   navigationController?.setNavigationBarHidden(false, animated: true)
        if isFromEdit == true{
            cardPrimaryInfo {
                if self.isprimary == 1{
                    self.btnCheck.setImage(UIImage(named: ImageName.Check), for: .normal)
                }else {
                    self.btnCheck.setImage(UIImage(named: ImageName.uncheck), for: .normal)
                }
            }
        }else{
            if Pay == true{
                self.btnCheck.setImage(UIImage(named: ImageName.uncheck), for: .normal)
                configureCardData()
            }else{
                print("Add New Address")
            }
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLayoutSubviews() {
        btnSave.cornerRadius = btnSave.frame.size.width / 2
        cardNumberView.roundCorners([.allCorners], radius: 15)
        expiredateView.roundCorners([.allCorners], radius: 15)
        CVVview.roundCorners([.allCorners], radius: 15)
        cardHoldernameView.roundCorners([.allCorners], radius: 15)
    }
    func setUpNIB(){
        PaymentmethodCollectionView.register(UINib(nibName: PaymentMethodCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PaymentMethodCollectionViewCell.identifier)
    }
    func SetupFont(){
        lblCardNumber.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblCardNumber.textColor = UIColor.App_NavyBlue
        txtCardNumber.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblExpiredate.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblExpiredate.textColor = UIColor.App_NavyBlue
        txtexpireDate.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblCVV.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblCVV.textColor = UIColor.App_NavyBlue
        txtCVV.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblCardHolderName.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblCardNumber.textColor = UIColor.App_NavyBlue
        txtcardHolderName.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        btnSave.titleLabel?.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        paymentmethodLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 48)
        paymentmethodLabel.textColor = UIColor.App_NavyBlue
        lblprimarycard.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 42)
        lblprimarycard.textColor = UIColor.App_NavyBlue
    }
    func cardNumberField(textfield: FormTextField) {
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        textfield.inputType = .integer
        //textfield.placeHolderColor = .white
        textfield.formatter = CardNumberFormatter()
        textfield.inputValidator = InputValidator(validation: validation)
    }
    func cardExpirationDateField(textField: FormTextField) {
        textField.inputType = .integer
        // textField.placeHolderColor = .white
        textField.formatter = CardExpirationDateFormatter()
        var validation = Validation()
        validation.minimumLength = 1
        let inputValidator = CardExpirationDateInputValidator(validation: validation)
        textField.inputValidator = inputValidator
    }
    func cvcField(textField: FormTextField){
        textField.inputType = .integer
        // textField.placeHolderColor = .white
        var validation = Validation()
        validation.maximumLength = "CVC".count
        validation.minimumLength = "CVC".count
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator
    }
    func isAllDataValid() -> Bool{
        var isValid = true
        if txtCardNumber.text  == ""{
            isValid = false
            AppUtility.alertMessage(CardNoEmptyMessage, viewcontroller: self)
        }else if txtCardNumber.text?.count ?? 0 < 19 || txtCardNumber.text?.count ?? 0 > 19{
            isValid = false
            AppUtility.alertMessage(CardNoValidMessage, viewcontroller: self)
        }else if txtexpireDate.text == ""{
            isValid = false
            AppUtility.alertMessage(CardExpireDateEmptyMessage, viewcontroller: self)
        }else if txtCVV.text == ""{
            isValid = false
            AppUtility.alertMessage(CardCVCEmptyMessage, viewcontroller: self)
        }else if txtcardHolderName.text == ""{
            isValid = false
            AppUtility.alertMessage(CardHolderNameEmptyMessage, viewcontroller: self)
        }else if cardSelect == false{
            isValid = false
            AppUtility.alertMessage(cardSelectionMessage, viewcontroller: self)
        } else if !validateExpireDate(txtexpireDate.text ?? "") {
            isValid = false
            AppUtility.alertMessage(CardExpireDateValidMessage, viewcontroller: self)
        }
        return isValid
    }
    
    /// validate expire date for credit card
    /// - Parameter text: expect date - formate: month/year
    /// - Returns: if date is from future return true else false
    func validateExpireDate(_ text: String) -> Bool {
        var isValid = true
        let ExpireDate = text.split(separator: "/")
        let monthString =  String(ExpireDate.first ?? "")
        let yearString = String(ExpireDate[1])
        let month = Int(monthString) ?? 0
        let year = Int(yearString) ?? 0 // two digit year
        let currentYear = Calendar.current.component(.year, from: Date())  % 100
        let currentMonth = Calendar.current.component(.month, from: Date())
        if year >= currentYear {
            if year == currentYear {
                if !(month >= currentMonth) {
                    isValid = false
                }
            }
        }
        return isValid
    }
    
    func AddCardDetail_data(){
        if isAllDataValid(){
            let ExpireDate = txtexpireDate.text?.split(separator: "/")
            let month =  String(ExpireDate?.first ?? "")
            let year = String(ExpireDate?[1] ?? "")
            let CardData = ReqCardDetail(cardID: "", cardNo: txtCardNumber.text ?? "", cvc: txtCVV.text ?? "", holderName: txtcardHolderName.text ?? "", isPrimary: "\(isprimary)", month: month , paymentType: String(paymentType), year: year)
//            LoaderManager.showLoader()
//            APIManager.share.AddCardDetail(params: CardData) { (Result) in
//                LoaderManager.hideLoader()
//                switch Result{
//                case .success(let response):
//                    print(response)
//                    if self.isFirsttime == true{
//                        let PaymentMethodVC = PaymentmethodViewController.instantiate(fromAppStoryboard: .Payment)
//                        self.navigationController?.pushViewController(PaymentMethodVC, animated: true)
//                    }else{
            
                        self.navigationController?.popViewController(animated: true)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
            
        }
            
    }
    
    func configureCardData() {
        if let payCardData = payCardData {
            self.txtCardNumber.text = payCardData.cardNumber
            self.txtexpireDate.text = payCardData.expireDate
            self.txtCVV.text = payCardData.cvv
            self.txtcardHolderName.text = payCardData.name
            
            btnCheck.isEnabled = false
            self.txtCardNumber.isEnabled = false
            self.txtexpireDate.isEnabled = false
            self.txtCVV.isEnabled = false
            self.txtcardHolderName.isEnabled = false
            PaymentmethodCollectionView.isUserInteractionEnabled = false
        }
    }
    
    func cardPrimaryInfo(completion: @escaping ()->()){
        LoaderManager.showLoader()
        APIManager.share.cardPrimaryInfo { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                print(response)
                self.cardDetail = response.data
                self.txtCardNumber.text = response.data?.cardNo
                self.txtexpireDate.text = "\(response.data?.month ?? 0)/\(response.data?.year ?? 0)"
                self.txtCVV.text = String(response.data?.cvc ?? 0)
                self.txtcardHolderName.text = response.data?.holderName
                self.isprimary = response.data?.isPrimary ?? 0
                self.paymentType = response.data?.paymentType ?? 0
                self.PaymentmethodCollectionView.reloadData()
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    func UpdateCardDetail_Data(){
        if isAllDataValid(){
            let ExpireDate = txtexpireDate.text
            let month = String(ExpireDate?.prefix(2) ?? "")
            let year = String(ExpireDate?.suffix(2) ?? "")
            let CardData = ReqCardDetail(cardID: String(CardID), cardNo: txtCardNumber.text ?? "", cvc: txtCVV.text ?? "", holderName: txtcardHolderName.text ?? "", isPrimary: "\(isprimary)", month: month, paymentType: String(paymentType), year: year)
            LoaderManager.showLoader()
            APIManager.share.UpdateCardDetail(params: CardData) { (Result) in
                LoaderManager.hideLoader()
                switch Result{
                case .success(let response):
                    print(response)
                    self.cardDetail = response.data
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    AppUtility.alertMessage(error.localizedDescription, viewcontroller: self)
                    print(error)
                }
            }
        }
      
    }
    func stripePaymentData(){
        LoaderManager.showLoader()
        APIManager.share.stripePaymentData(order_id: orderID.description,card_id: CardID.description) { (Result) in
            LoaderManager.hideLoader()
            switch Result{
            case .success(let response):
                let ServiceHomeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
                ServiceHomeVC.view.makeToast(response.message)
                self.navigationController?.pushViewController(ServiceHomeVC, animated: true)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    @IBAction func btnCheckTapped(_ sender: UIButton) {
        if isprimary == 0{
            btnCheck.setImage(UIImage(named: ImageName.Check), for: .normal)
            isprimary = 1
        }else {
            btnCheck.setImage(UIImage(named: ImageName.uncheck), for: .normal)
            isprimary = 0
        }
    }
    @IBAction func btnSavetapped(_ sender: UIButton) {
        if isFromEdit{
            self.UpdateCardDetail_Data()
        }else{
            if Pay == true{
                btnSave.setTitle("PAY", for: .normal)
                stripePaymentData()
            }else{
                self.AddCardDetail_data()
            }
        }
    }
    
    
}
extension AddNewPaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PaymentmethodCollectionView.dequeueReusableCell(withReuseIdentifier: PaymentMethodCollectionViewCell.identifier, for: indexPath) as! PaymentMethodCollectionViewCell
        if indexPath.row == 0{
            cell.lblmethodName.text = "Debit Card"
            cell.btnCheck.isHidden = cardDetail == nil ? false : true
            if cardDetail?.paymentType == 1{
                cell.btnCheck.isHidden = false
            }
            cell.btnCheck.isHidden = paymentType == 1 ? false : true
        }else{
            cell.lblmethodName.text = "Credit Card"
            if cardDetail?.paymentType == 2{
                cell.btnCheck.isHidden = false
            }
            cell.btnCheck.isHidden = paymentType == 2 ? false : true
        }
        cardSelect = cell.btnCheck.isHidden
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PaymentMethodCollectionViewCell
        if indexPath.row == 0{
            paymentType = 1
        }else{
            paymentType = 2
        }
        cardSelect = true
        PaymentmethodCollectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! PaymentMethodCollectionViewCell
        currentCell.btnCheck.isHidden = true
    }
}

extension AddNewPaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: PaymentmethodCollectionView.frame.size.height, height: PaymentmethodCollectionView.frame.size.height)
    }
    
}
