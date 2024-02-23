//
//  BioTableViewCell.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class BioTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBio: UILabel!
    
    var providerInfo :  ServiceProviderInfoData?{
        didSet{
            lblBio.text = providerInfo?.dataDescription ?? ""
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
    
}
