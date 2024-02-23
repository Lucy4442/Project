//
//  ServiceCategoriesCell.swift
//  Helpy
//
//  Created by mac on 07/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//MARK: ==========Protocol Delegate==========
protocol checkbuttonDelegate {
    func checkButtonTapped(at index: IndexPath, sender: UIButton)
}

//MARK: ==========ServiceCategoriesCell==========
class ServiceCategoriesCell: UITableViewCell {
    
    //MARK: ==========Variable==========
    var delegate: checkbuttonDelegate!
    var indexpath: IndexPath!
    var Categories = ServiceCategories() {
        didSet {
            lblServiceTItle.text = Categories.Name!
            LblServiceDetail.text = Categories.Detail!
            ImgService.image = UIImage(named: Categories.Image ?? "")
            btnCheck.isSelected = Categories.isselected
            btnCheck.setImage(Categories.isselected ? UIImage(named: ImageName.Check) : UIImage(named: ImageName.uncheck) , for: .normal)
        }
    }
    
    //MARK: ==========Outlet==========
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var ServiceView: UIView!
    @IBOutlet weak var ImgService: UIImageView!
    @IBOutlet weak var lblServiceTItle: UILabel!
    @IBOutlet weak var LblServiceDetail: UILabel!
    
    //MARK: ==========awakeFromNib==========
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    //MARK: ==========setSelected==========
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        ServiceView.roundCorners([.allCorners], radius: 20) 
    }
    
    //MARK: ==========Check button Action==========
    @IBAction func btnCheckTapped(_ sender: UIButton) {
        self.delegate?.checkButtonTapped(at: indexpath, sender: sender)
    }
}
