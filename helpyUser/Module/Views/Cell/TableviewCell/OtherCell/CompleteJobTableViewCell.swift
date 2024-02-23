//
//  CompleteJobTableViewCell.swift
//  Helpy
//
//  Created by mac on 16/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol CompleteJobActionDelegate: AnyObject {
    func CompleteJobTapped()
}

class CompleteJobTableViewCell: UITableViewCell {

    var delegate: CompleteJobActionDelegate?
    
    @IBOutlet weak var btnCompleteJob: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        btnCompleteJob.cornerRadius = btnCompleteJob.frame.size.width / 2
    }
    
    @IBAction func btnCompleteJobTapped(_ sender: UIButton) {
        delegate?.CompleteJobTapped()
    }
}
