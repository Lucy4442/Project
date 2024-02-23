//
//  HelpTableViewCell.swift
//  HelpyService
//
//  Created by mac on 01/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    
    var help = Help(){
        didSet{
            lblDetail.text = help.Detail
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners([.allCorners], radius: 15)
        
    }
}
