//
//  MoreOptionTableViewCell.swift
//  helpyUser
//
//  Created by mac on 07/05/21.
//

import UIKit
protocol MoreOptionDelegate: AnyObject {
    func MoreButtonAction(sender: UIButton)
}
class MoreOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var btnMoreoption: UIButton!
    
    weak var moredelegate : MoreOptionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        btnMoreoption.roundCorners([.allCorners], radius: 15)
    }
    @IBAction func MoreOptionTapped(_ sender: UIButton) {
        moredelegate?.MoreButtonAction(sender: sender)
    }
    
}
