//
//  OrderDetailTableViewCell.swift
//  Helpy
//
//  Created by mac on 28/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

  //  @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var ImgProfile: UIImageView!
    @IBOutlet weak var lblOrderTitle: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderDetail: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblTitleStartTime: UILabel!
    @IBOutlet weak var lblTitleEndTime: UILabel!
    
    var bookingDetailObject: BookingData? {
        didSet {
            self.lblOrderTitle.text = bookingDetailObject?.parentCategory
            self.ImgProfile.getImage(url: bookingDetailObject?.categoryImage ?? "", placeholderImage: ImageName.Placeholder)
            self.lblOrderDate.text = bookingDetailObject?.date
            if let description = bookingDetailObject?.descriptionField {
                self.lblOrderDetail.text = description
            }else{
                self.lblOrderDetail.isHidden = true
            }
            if let startTime = bookingDetailObject?.startTime {
                self.lblStartTime.text = Date.getFormatTime12Hour(from: startTime) ?? startTime
            }
            if let endTime = bookingDetailObject?.endTime {
                self.lblEndTime.text = Date.getFormatTime12Hour(from: endTime) ?? endTime
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.contentView.roundCorners([.allCorners], radius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        ImgProfile.roundCorners([.allCorners], radius: 20)
      //  DetailView.roundCorners([.allCorners], radius: 20)
    }
}
