//
//  AddOnTableViewCell.swift
//  helpyUser
//
//  Created by mac on 28/06/21.
//

import UIKit
protocol addOnDelegate: AnyObject {
    func addOnAction(sender: UIButton)
}
class AddOnTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    var delegate: addOnDelegate?
    var Index =  IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setUpFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners([.allCorners], radius: 20)
    }
    func setUpFont(){
        titleLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 46)
        titleLabel.textColor = UIColor.App_NavyBlue
        priceLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
        priceLabel.textColor = UIColor.App_Red
    }
    func configureCell(data: Addon?){
        titleLabel.text = data?.addonName
        priceLabel.text = "Price: "+"$"+String(data?.price ?? 0)
        btnCheck.isSelected = data?.isSelected ?? false
        btnCheck.setImage(data?.isSelected ?? false ? UIImage(named: ImageName.Check) : UIImage(named: ImageName.uncheck) , for: .normal)
    }
    @IBAction func btnDetailTapped(_ sender: UIButton) {
        delegate?.addOnAction(sender: sender)
    }
    @IBAction func btnCheckTapped(_ sender: Any) {
    }
}
