//
//  CompleteJobDetailTableViewCell.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class CompleteJobDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgJob: UIImageView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobSubtitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var userPaymentData : UserPayment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setUpFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners([.allCorners], radius: 15)
        imgJob.roundCorners([.allCorners], radius: 15)
    }
    func  setUpFont(){
        lblJobTitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 48)
        lblPrice.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        lblJobSubtitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    
    func configurePaymentCell(data: PaymentData?){
        lblJobTitle.text = data?.category
        lblJobSubtitle.text = data?.date
        lblPrice.text = "$" + String(data?.amountPayble ?? 0)
        imgJob.getImage(url: data?.categoryImage ?? "", placeholderImage: ImageName.Placeholder)
    }
    
    func configurePaymentCell(data: OrderPaymentDetail?){
        lblJobTitle.text = data?.categoryName
        lblJobSubtitle.text = data?.date
        lblPrice.text = "$" + String(data?.totalPrice ?? 0)
        imgJob.getImage(url: data?.categoryImage ?? "", placeholderImage: ImageName.Placeholder)
    }
}
