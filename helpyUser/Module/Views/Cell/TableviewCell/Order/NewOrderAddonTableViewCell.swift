//
//  NewOrderAddonTableViewCell.swift
//  helpyUser
//
//  Created by mac on 29/06/21.
//

import UIKit

protocol AddRemoveButtonDelegate: AnyObject {
    func RemoveAction(sender: UIButton)
}

class NewOrderAddonTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    weak var delegate: AddRemoveButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setUpFont()
    }
    func setUpFont(){
        titleLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 46)
        titleLabel.textColor = UIColor.App_NavyBlue
        PriceLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        PriceLabel.textColor = UIColor.App_Red
    }
    override func draw(_ rect: CGRect) {
        btnRemove.roundCorners([.allCorners], radius: 10)
        mainView.roundCorners([.allCorners], radius: 20)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configureCell(data: Addon?){
            titleLabel.text = data?.addonName
            PriceLabel.text = " Price: $"+String(data?.price ?? 0)
    }
    func configureiscartCell(data: BookingData?){
        titleLabel.text = data?.categoryLabelType
        if let price = data?.minPrice{
            PriceLabel.text = "Price: $" + String(price)
        }else{
            PriceLabel.text = "Price: $" + String(data?.price ?? 0)
        }
        btnRemove.setTitle(String(data?.categoryIsCart ?? 0), for: .normal)
        btnRemove.backgroundColor = .clear
        btnRemove.setTitleColor(UIColor.App_Gray, for: .normal)
    }
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        delegate?.RemoveAction(sender: sender)
    }
}
