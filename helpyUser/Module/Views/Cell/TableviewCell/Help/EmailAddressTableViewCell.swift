//
//  EmailAddressTableViewCell.swift
//  helpyUser
//
//  Created by mac on 11/01/21.
//

import UIKit

class EmailAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var EmailAddressView: UIView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        EmailAddressView.roundCorners([.allCorners], radius: 15)
    }
}
