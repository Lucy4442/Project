//
//  PaymentMethodTableViewCell.swift
//  helpyUser
//
//  Created by mac on 06/01/21.
//

import UIKit
import FormTextField
class PaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var CardBG: UIImageView!
    @IBOutlet weak var imgcheck: UIImageView!
    @IBOutlet weak var Holdername: UITextField!
    @IBOutlet weak var txtExpireDate: FormTextField!
    @IBOutlet weak var txtCVC: FormTextField!
    @IBOutlet weak var txtCardNumber: FormTextField!
    var validation = Validation()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetupFont()
        selectionStyle = .none
    }
    
    func SetupFont(){
        txtCardNumber.font = UIFont.Medium
        txtExpireDate.font = UIFont.Medium
        txtCVC.font = UIFont.Medium
        Holdername.font = UIFont.Medium
    }
    
    func configureCell(data: CardDetail?){
        txtCardNumber.text = data?.cardNo
        let cvcNumber = (data?.cvc ?? 0) == 0 ? "***" : "\(String(describing: data?.cvc))"
        txtCVC.text = cvcNumber
        txtExpireDate.text = "\(String(data?.month ?? 0 ))/\(String(data?.year ?? 0))"
        Holdername.text = data?.holderName
       // imgcheck.image = UIImage(named: ImageName.uncheck)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // imgcheck.image = UIImage(named: ImageName.Check)
    }
    
}
