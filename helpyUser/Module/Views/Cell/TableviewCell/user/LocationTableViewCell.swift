//
//  LocationTableViewCell.swift
//  HelpyService
//
//  Created by mac on 30/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configure() {
        setUpMapView()
    }

    func setUpMapView() {
        let map = HelpyLocationView.instantiate()
        map.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: mapView.frame.size)
        mapView.addSubview(map)
    }
    
}
