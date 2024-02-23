//
//  SendInvoiceTableViewCell.swift
//  Helpy
//
//  Created by mac on 16/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol SendInvoiceActionDelegate: AnyObject {
    func SendInvoiceTapped()
    func CustomizeViewAction()
}

class SendInvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var btnSendInvoice: UIButton!
    @IBOutlet weak var CustomizeView: UIView!
    @IBOutlet weak var lblCustomize: UILabel!
    
    var delegate: SendInvoiceActionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        btnSendInvoice.cornerRadius = btnSendInvoice.frame.size.width / 2
        CustomizeView.roundCorners([.topLeft, .bottomLeft], radius: 15)
    }
  
    @IBAction func btnSendInvoiceTapped(_ sender: Any) {
        delegate?.SendInvoiceTapped()
    }
    
    @IBAction func CustomizeViewTapped(_ sender: UIControl) {
        delegate?.CustomizeViewAction()
    }
}
