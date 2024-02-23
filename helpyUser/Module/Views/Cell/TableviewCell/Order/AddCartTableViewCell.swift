//
//  AddCartTableViewCell.swift
//  helpyUser
//
//  Created by mac on 01/07/21.
//

import UIKit
protocol AddRemoveCartDelegate{
    func addCartAction()
    func removeCartAction()
}

class AddCartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var removeCartButton: UIButton!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var cartCountView: UIView!
    @IBOutlet weak var cartTitleLabel: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    var delegate: AddRemoveCartDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setUpFont()
        addCartButton.addTarget(self, action: #selector(addCartButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        removeCartButton.addTarget(self, action: #selector(removeCartButtonAction(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func draw(_ rect: CGRect) {
        cartView.roundCorners([.allCorners], radius: 20)
        cartCountView.roundCorners([.allCorners], radius: 10)
        addCartButton.roundCorners([.topRight, .bottomRight], radius: 10)
        removeCartButton.roundCorners([.topLeft, .bottomLeft], radius: 10)
    }
    func setUpFont(){
        cartTitleLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 46)
        cartCountLabel.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 36)
    }
    
    func configureCell(data: ServiceDetail?){
        let title = (data?.LabelType ?? data?.name ?? data?.descriptionField ?? "")
        cartTitleLabel.text = title
    }
    @objc func addCartButtonAction(sender: UIButton){
        delegate?.addCartAction()
    }
    @objc func removeCartButtonAction(sender: UIButton){
        delegate?.removeCartAction()
    }
}
