//
//  AddAddressTableViewCell.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol SaveActionDelegate: AnyObject {
    func saveTapped()
    func editAddress()
}

class AddAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    weak var delegate: SaveActionDelegate?
    
    var addressObject: Address? {
        didSet {
            if let mobileNumber = addressObject?.mobile {
                self.lblNumber.text = mobileNumber
            }
            self.lblUserName.text = addressObject?.name
        }
    }
    var OrderData : AddressDetails?{
        didSet{
            if let mobileNumber = OrderData?.mobile {
                self.lblNumber.text = mobileNumber
            }
            self.lblUserName.text = OrderData?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        AddressView.roundCorners([.allCorners], radius: 20)
        btnSave.cornerRadius = btnSave.frame.size.width / 2
    }
    override func layoutSubviews() {
        
    }
    @IBAction func btnSaveTapped(_ sender: Any) {
        print("Save tapped...")
        delegate?.saveTapped()
    }
    @IBAction func btnEditTapped(_ sender: Any) {
        print("Edit tapped...")
        delegate?.editAddress()
    }
}
