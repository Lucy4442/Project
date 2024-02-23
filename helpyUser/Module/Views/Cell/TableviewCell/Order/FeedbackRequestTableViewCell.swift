//
//  FeedbackRequestTableViewCell.swift
//  helpyUser
//
//  Created by mac on 23/06/21.
//

import UIKit

class FeedbackRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var feedbuttonView: UIView!
    @IBOutlet weak var btnfeedbackreq: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        btnfeedbackreq.roundCorners([.allCorners], radius: 20)
        feedbuttonView.roundCorners([.allCorners], radius: 20)
        mainView.roundCorners([.allCorners], radius: 20)
    }
}
