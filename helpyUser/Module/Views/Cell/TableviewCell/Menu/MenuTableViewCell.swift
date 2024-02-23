//
//  MenuTableViewCell.swift
//  Helpy
//
//  Created by mac on 09/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//MARK: ==========MenuTableViewCell==========
class MenuTableViewCell: UITableViewCell {

    //MARK: ==========Outlet==========
    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var MenuImageView: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    
    //MARK: ==========awakeFromNib==========
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    //MARK: ==========setSelected==========
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
