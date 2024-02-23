//
//  UserMenuCollectionViewCell.swift
//  Helpy
//
//  Created by mac on 17/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UserMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpFont()
    }
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        bgView.clipsToBounds = true
    }
    func setUpFont(){
        lblMenuName.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }

}
