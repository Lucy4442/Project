//
//  OrderCotactTableViewCell.swift
//  Helpy
//
//  Created by mac on 28/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderCotactTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var NextView: UIControl!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var ProfileTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        NextView.roundCorners([.allCorners], radius: 20)
        contactView.roundCorners([.allCorners], radius: 20)
        ProfileView.roundCorners([.allCorners], radius: 20)
        imgProfile.roundCorners([.allCorners], radius: 20)

    }
    
}
