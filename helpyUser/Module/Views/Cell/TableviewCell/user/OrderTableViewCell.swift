//
//  OrderTableViewCell.swift
//  Helpy
//
//  Created by mac on 24/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var NextView: UIControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var paymentRequiredLabel: UILabel!
    
    var OrderData: OngoingOrder? {
        didSet {
            lblTitle.text = OrderData?.parentCategory
            lblDate.text = OrderData?.date
            imgUser.getImage(url: OrderData?.image ?? "", placeholderImage: ImageName.Placeholder)
        }
    }
    
    
    var previousOrderDataObject: PreviousOrdersData? {
        didSet {
            lblTitle.text = previousOrderDataObject?.order?.parentName
            lblDate.text = previousOrderDataObject?.order?.date
            imgUser.getImage(url: previousOrderDataObject?.order?.image ?? "", placeholderImage: ImageName.Placeholder)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupFont()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setupFont(){
        lblTitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 46)
        lblTitle.textColor = UIColor.App_NavyBlue
        lblDate.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        lblDate.textColor = UIColor.App_NavyBlue
    }
    override func draw(_ rect: CGRect) {
        orderView.roundCorners([.allCorners], radius: 20)
        NextView.roundCorners([.allCorners], radius: 15)
        imgUser.roundCorners([.allCorners], radius: 20)
    }
}
