//
//  AddressManagerTableViewCell.swift
//  Helpy
//
//  Created by mac on 19/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AddressManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserMobileNumberLabel: UILabel!
    @IBOutlet weak var UserAddressLabel: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    
    var userAddressObject : AddressDetails? {
        didSet {
            self.UserNameLabel.text = userAddressObject?.name
            self.UserAddressLabel.text = userAddressObject?.address
            self.UserAddressLabel.text = "\(userAddressObject?.address ?? ""), \(userAddressObject?.landmark ?? ""), \(userAddressObject?.city ?? ""), \(userAddressObject?.state ?? "")"
            
            if let mobileNumber = userAddressObject?.mobile {
                self.UserMobileNumberLabel.text = mobileNumber
            }
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
    override func layoutSubviews() {
        AddressView.roundCorners([.allCorners], radius: 20)
    }
}
