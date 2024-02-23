//
//  FeedbackDetailTableViewCell.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class FeedbackDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblFeedBack: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var Lblname: UILabel!
    @IBOutlet weak var lineView: UIView!
    var ReviewData : Review?{
        didSet {
            lblFeedBack.text = ReviewData?.comment
            Lblname.text = ReviewData?.userName
            imgProfile.getImage(url: ReviewData?.avatar ?? "", placeholderImage: ImageName.Placeholder)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners(.allCorners, radius: 15)
        imgProfile.roundCorners(.allCorners, radius: 15)
    }
    func configurePaymentCell(data: PaymentData?){
        Lblname.text = data?.username
        lblFeedBack.text = data?.feedback
        imgProfile.getImage(url: data?.userImage ?? "", placeholderImage: ImageName.Placeholder)
    }
}
