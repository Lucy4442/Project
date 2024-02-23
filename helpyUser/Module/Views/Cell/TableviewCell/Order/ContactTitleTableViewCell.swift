//
//  ContactTitleTableViewCell.swift
//  helpyUser
//
//  Created by mac on 08/02/21.
//

import UIKit
protocol favoritebuttonDelegate: AnyObject {
    func favoriteAction(button: UIButton)
}


class ContactTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLocationDetail: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnfavorite: UIButton!
    
    
    var  delegate: favoritebuttonDelegate?
    var providerInfo :  ServiceProviderInfoData?{
        didSet{
            imgUser.getImage(url: providerInfo?.avatar ?? "", placeholderImage: ImageName.Placeholder)
            lblUsername.text = providerInfo?.name
            lblLocationDetail.text = providerInfo?.mobile ?? ""
            btnLocation.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners([.allCorners], radius: 15)
        imgUser.roundCorners([.allCorners], radius: 15)
    }
    
    @IBAction func btnFavoriteTapped(_ sender: UIButton) {
        delegate?.favoriteAction(button: sender)
    }
}
