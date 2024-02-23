//
//  PaymentDetailTableViewCell.swift
//  Helpy
//
//  Created by mac on 16/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class PaymentDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var LineView: UIView!
    @IBOutlet weak var Line: UIView!
    
    var Payment = PaymentDetail() {
        didSet{
            lblTitle.text = Payment.title
            lblTitle.textColor = UIColor(named: Payment.textColor ?? "")
            lblDetail.text = Payment.Detail
            lblDetail.textColor = UIColor(named: Payment.textColor ?? "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
//    func configureUserPaymentCell(data: UserPaymentDetail?){
//
//    }
}
