//
//  PreviousOrderTableViewCell.swift
//  Helpy
//
//  Created by mac on 29/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class PreviousOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var NextView: UIControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        NextView.roundCorners([.allCorners], radius: 20)
    }
    
}
