//
//  ContactTableViewCell.swift
//  Helpy
//
//  Created by mac on 15/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ContactActionDelegate {
    func UserViewTapped(sender: UIControl)
}

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var BtnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var UserView: UIView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var ImgNextArrow: UIImageView!
    @IBOutlet weak var UserProfile: UIImageView!
    @IBOutlet weak var ImgLocation: UIImageView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblLocation: UILabel!
    
    var Delegate: ContactActionDelegate?
   // var userPaymentData : UserPayment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetupFont()
        selectionStyle = .none
    }
    func SetupFont(){
        LblTitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 48)
        LblLocation.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    override func layoutSubviews() {
        UserView.roundCorners([.allCorners], radius: 20)
        contactView.roundCorners([.allCorners], radius: 10)
        nextView.roundCorners([.allCorners], radius: 10)
        UserProfile.roundCorners([.allCorners], radius: 20)
    }
    
    func configureUserPaymentCell(data: PaymentData?){
        UserProfile.getImage(url: data?.spImage ?? "", placeholderImage: ImageName.Placeholder)
        LblTitle.text = data?.spName ?? ""
        LblLocation.text = ""
        ImgLocation.isHidden = true
    }
    @IBAction func UserViewTapped(_ sender: UIControl) {
        print("User tapped Action")
        Delegate?.UserViewTapped(sender: sender)
    }
    
}
