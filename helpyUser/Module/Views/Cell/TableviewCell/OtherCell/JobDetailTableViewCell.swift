//
//  JobDetailTableViewCell.swift
//  Helpy
//
//  Created by mac on 16/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class JobDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var ImgJob: UIImageView!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var lblJobCurrentDate: UILabel!
    @IBOutlet weak var txtJobDetail: UITextView!
    @IBOutlet weak var jobFromDate: UILabel!
    @IBOutlet weak var jobToDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutSubviews() {
        DetailView.roundCorners([.allCorners], radius: 20)
        ImgJob.roundCorners([.allCorners], radius: 20)
    }
    
//    func setUpData(with title: optionSelection) {
//        if title == .Service {
//            lblJobTitle.text = "Cleaning Service"
//            lblJobCurrentDate.text = "29 August 2020"
//            ImgJob.image = UIImage(named: "CleaningService")
//        }else{
//            print("else section")
//        }
//    }
}
