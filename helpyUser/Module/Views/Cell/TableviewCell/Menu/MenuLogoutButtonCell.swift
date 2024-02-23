//
//  MenuLogoutButtonCell.swift
//  Helpy
//
//  Created by mac on 09/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol LogoutActionDelegate: AnyObject {
    func LogoutTapped()
}

//MARK: ==========MenuLogoutButtonCell==========
class MenuLogoutButtonCell: UITableViewCell {
    
    var delegate: LogoutActionDelegate?
    
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
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    @IBAction func btnLogouttapped(_ sender: Any) {
        delegate?.LogoutTapped()
    }
}
