//
//  OrderHeaderView.swift
//  Helpy
//
//  Created by mac on 24/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class OrderHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var OrderSegment: UISegmentedControl!
    
    let segSelectedAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpOrderHeaderView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpOrderHeaderView()
    }
    func setUpOrderHeaderView() {
        Bundle.main.loadNibNamed("OrderHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        OrderSegment.setTitleTextAttributes(segSelectedAttributes as? [NSAttributedString.Key : Any], for: .selected)
        OrderSegment.backgroundColor = UIColor.white
        
    }
}
