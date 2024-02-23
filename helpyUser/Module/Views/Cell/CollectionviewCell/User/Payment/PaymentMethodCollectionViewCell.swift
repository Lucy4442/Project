//
//  PaymentMethodCollectionViewCell.swift
//  helpyUser
//
//  Created by mac on 05/01/21.
//

import UIKit

class PaymentMethodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var methodView: UIView!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var lblmethodName: UILabel!
    @IBOutlet weak var imgmethod: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCheck.isHidden = true
        self.contentView.isUserInteractionEnabled = true
    }
    override func draw(_ rect: CGRect) {
        methodView.roundCorners([.allCorners], radius: 20)
    }
    func setUpFont(){
        lblmethodName.font =  UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    @IBAction func methodViewTapped(_ sender: UIControl) {
    }
}
