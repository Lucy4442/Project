//
//  HeaderView.swift
//  Helpy
//
//  Created by mac on 18/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ButtonActionDelegate : AnyObject {
    func ViewAllTapped()
}

class HeaderView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var btnViewall: UIButton!
    
    var delegate: ButtonActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    @IBAction func ViewAllTapped(_ sender: Any) {
        delegate?.ViewAllTapped()
    }
}
