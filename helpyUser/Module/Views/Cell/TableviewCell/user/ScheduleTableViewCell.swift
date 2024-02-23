//
//  ScheduleTableViewCell.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ScheduleActionDelegate: AnyObject {
    func PickupTapped(startTime: UIView, EndTime: UIView, Date: UIView, selectTime: UIButton)
    func startTime(startTime: String, endTime: String)
    func endTime(startTime: String, endTime: String)
}

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var ScheduleView: UIView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var btnPickupTime: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var EndTimeView: UIView!
    @IBOutlet weak var StartTimeVIew: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var endtimeTitle: UILabel!
    @IBOutlet weak var starttimeTitle: UILabel!
    @IBOutlet weak var workDateLabel: UILabel!
    var delegate: ScheduleActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        refreshTimeView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func draw(_ rect: CGRect) {
        ScheduleView.roundCorners([.allCorners], radius: 20)
        btnPickupTime.roundCorners([.allCorners], radius: 15)
        StartTimeVIew.roundCorners([.allCorners], radius: 15)
        EndTimeView.roundCorners([.allCorners], radius: 15)
        dateView.roundCorners([.allCorners], radius: 15)
    }
    
    
    func refreshTimeView() {
        StartTimeVIew.isHidden = true
        EndTimeView.isHidden = true
        dateView.isHidden = true
        btnPickupTime.isHidden = false
    }
    
    @IBAction func btnPickupTapped(_ sender: UIButton) {
        delegate?.PickupTapped(startTime: StartTimeVIew, EndTime: EndTimeView, Date: dateView, selectTime: btnPickupTime)
    }
    
    @IBAction func startTimeTapped(_ sender: UIControl) {
        delegate?.startTime(startTime: startTime.text ?? "", endTime: endTime.text ?? "")
    }
    
    @IBAction func endTimeTapped(_ sender: UIControl) {
        delegate?.endTime(startTime: startTime.text ?? "", endTime: endTime.text ?? "")
    }
    
    
    @IBAction func dateButtonClicked(_ sender: Any) {
        delegate?.PickupTapped(startTime: StartTimeVIew, EndTime: EndTimeView, Date: dateView, selectTime: btnPickupTime)
    }
}
