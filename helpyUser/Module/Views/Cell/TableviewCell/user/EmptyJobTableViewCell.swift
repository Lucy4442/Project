//
//  EmptyJobTableViewCell.swift
//  Helpy
//
//  Created by mac on 28/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class EmptyJobTableViewCell: UITableViewCell {

    @IBOutlet weak var imgEmptyJob: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var TitleView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        TitleView.roundCorners([.allCorners], radius: 20)
        imgEmptyJob.roundCorners([.allCorners], radius: 20)
    }
}
