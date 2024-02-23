//
//  TrackContactTableViewCell.swift
//  helpyUser
//
//  Created by mac on 08/02/21.
//

import UIKit

protocol  TrackContactTableViewCellDelegate{
    func StoreButtonTapped()
}

class TrackContactTableViewCell: UITableViewCell {
    
    @IBOutlet var detailBackgroundView: UIView!
    @IBOutlet var buttonBackgroundView: UIView!
    @IBOutlet var providerNameLabel: UILabel!
    @IBOutlet var mobileNumberLabel: UILabel!
    @IBOutlet var providerImageView: UIImageView!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var messageButton: UIButton!
    
    var delegate: TrackContactTableViewCellDelegate?
    var ongoingDetail = false
    var bookingDetailObject: BookingData? {
        didSet {
            if ongoingDetail == true {
                self.providerNameLabel.text = bookingDetailObject?.providerName
            }else{
                self.providerNameLabel.text = bookingDetailObject?.username
            }
            
            if let mobileNumber = bookingDetailObject?.mobile {
                self.mobileNumberLabel.text = mobileNumber
            } else {
                callButton.isHidden = true
            }
            if let imageString = bookingDetailObject?.avatar {
                providerImageView.getImage(url: imageString, placeholderImage: ImageName.Placeholder)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        detailBackgroundView.roundCorners([.allCorners], radius: 18)
        buttonBackgroundView.roundCorners([.allCorners], radius: 15)
        providerImageView.roundCorners([.allCorners], radius: 15)
    }
    
    @IBAction func StoreBtntapped(_ sender: UIButton) {
        self.delegate?.StoreButtonTapped()
    }
}
