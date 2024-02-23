//
//  GeneralCell.swift
//  Helpy
//
//  Created by mac on 09/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//MARK: ==========GeneralCell==========
class GeneralCell: UITableViewCell {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    //MARK: ==========awakeFromNib==========
    override func awakeFromNib() {
        super.awakeFromNib()
        btnViewAll.isHidden = true
        selectionStyle = .none
    }

    //MARK: ==========setSelected==========
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
}
