//
//  EmailDescriptionTableViewCell.swift
//  helpyUser
//
//  Created by mac on 11/01/21.
//

import UIKit

class EmailDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var EmailDescriptionView: UIView!
    
    @IBOutlet weak var txtEmailDescription: TextViewPlaceHolder!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        EmailDescriptionView.roundCorners([.allCorners], radius: 15)
    }
}
