//
//  PickUpTimeTableViewCell.swift
//  Helpy
//
//  Created by mac on 23/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class PickUpTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTimeIterval: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        timeView.roundCorners([.allCorners], radius: 20)
    }
    
}
