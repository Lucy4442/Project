//
//  UserServiceTableViewCell.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UserServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var ServiceView: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    var Service = UserService() {
        didSet{
            imgService.image = UIImage(named: Service.image ?? "")
            lblServiceName.text = Service.name!
        }
    }
    
    var subsubObject: ServiceDetail? {
        didSet {
            self.imgService.getImage(url: subsubObject?.image ?? "", placeholderImage: ImageName.Placeholder)
            self.lblServiceName.text = subsubObject?.name
            if let price = subsubObject?.minPrice{
                self.priceLabel.text = "$" + String(price)
            }else{
                self.priceLabel.text = "$" + String(subsubObject?.price ?? 0)
            }
        }
    }
    var OrderData: BookingData?{
        didSet{
            self.imgService.getImage(url: OrderData?.categoryImage ?? "", placeholderImage: ImageName.Placeholder)
            if let name = OrderData?.subCategory{
                self.lblServiceName.text = name
            }else{
                self.lblServiceName.text = OrderData?.parentCategory
            }
            if let price = OrderData?.minPrice{
                self.priceLabel.text = "$" + String(price)
            }else{
                self.priceLabel.text = "$" + String(OrderData?.price ?? 0)
            }
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
    
    override func layoutSubviews() {
        ServiceView.roundCorners([.allCorners], radius: 20)
        imgService.roundCorners([.allCorners], radius: 20)
    }
    
    func ConfigureCell(data: ServiceDetail?){
        lblServiceName.text = data?.name ?? ""
        imgService.getImage(url: data?.image ?? "", placeholderImage: ImageName.Placeholder)
    }
}
