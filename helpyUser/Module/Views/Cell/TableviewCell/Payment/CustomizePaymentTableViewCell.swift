//
//  CustomizePaymentTableViewCell.swift
//  HelpyService
//
//  Created by mac on 02/06/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
protocol AddCustomeDelegate : AnyObject {
    func AddAction(name: String, Amount: String)
}
class CustomizePaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtproductName: UITextField!
    
    var Delegate: AddCustomeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        Delegate?.AddAction(name: txtproductName.text ?? "", Amount: txtAmount.text ?? "")
    }
}
