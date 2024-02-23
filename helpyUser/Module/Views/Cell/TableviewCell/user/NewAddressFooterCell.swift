//
//  NewAddressFooterCell.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class NewAddressFooterCell: UITableViewCell {

    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnLocationTapped(_ sender: Any) {
    }
}
