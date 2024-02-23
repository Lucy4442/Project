
//
//  LocationDetailTableViewCell.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class LocationDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurePaymentcell(data: PaymentData?){
        lblName.text = data?.spName
        lblAddress.text = data?.spAddress
    }
}
