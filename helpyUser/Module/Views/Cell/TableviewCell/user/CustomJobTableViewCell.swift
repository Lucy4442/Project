//
//  CustomJobTableViewCell.swift
//  Helpy
//
//  Created by mac on 22/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CustomJobTableViewCell: UITableViewCell {

    @IBOutlet weak var txtJobName: UITextField!
    @IBOutlet weak var txtJobDetails: UITextView!
    @IBOutlet weak var txtView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        txtJobName.setLeftPaddingPoints(20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        txtJobName.roundCorners([.allCorners], radius: 20)
        txtView.roundCorners([.allCorners], radius: 20)
    }
}
