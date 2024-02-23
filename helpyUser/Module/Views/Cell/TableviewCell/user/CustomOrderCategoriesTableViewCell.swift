//
//  CustomOrderCategoriesTableViewCell.swift
//  Helpy
//
//  Created by mac on 21/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol OrderActionDelegate: AnyObject {
    func PreviousOrderTapped()
    func AddCustomOrderTapped()
}

class CustomOrderCategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var previouseOrder: UIControl!
    @IBOutlet weak var CustomOrder: UIControl!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    weak var delegate: OrderActionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func draw(_ rect: CGRect) {
        previouseOrder.roundCorners([.allCorners], radius: 20)
        CustomOrder.roundCorners([.allCorners], radius: 20)
        SearchView.roundCorners([.allCorners], radius: 20)
    }

    @IBAction func PreviousOrderTapped(_ sender: Any){
        print("previous Tapped")
        delegate?.PreviousOrderTapped()
    }
    
    @IBAction func AddCustomOrdertapped(_ sender: UIControl) {
        print("Add Custom Order")
        delegate?.AddCustomOrderTapped()
    }
}
