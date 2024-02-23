//
//  BannerTableViewCell.swift
//  Helpy
//
//  Created by mac on 10/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//MARK: ==========BannerTableViewCell==========
class BannerTableViewCell: UITableViewCell {

    //MARK: ==========Outlet==========
    @IBOutlet weak var Imgbanner: UIImageView!
    
    //MARK: ==========awakeFromNib==========
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    //MARK: ==========setSelected==========
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        Imgbanner.roundCorners([.allCorners], radius: 20)
    }
    
}
