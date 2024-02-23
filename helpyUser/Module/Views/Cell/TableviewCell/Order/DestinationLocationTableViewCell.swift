//
//  DestinationLocationTableViewCell.swift
//  HelpyService
//
//  Created by mac on 28/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import MapKit

class DestinationLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var imglocation: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var mapKitView: MKMapView!
    
    var latitude : String?
    var logitude : String?
    
    var providerInfo :  ServiceProviderInfoData?{
        didSet{
            lblAddress.text = providerInfo?.address ?? ""
            latitude = providerInfo?.latitude ?? ""
            logitude = providerInfo?.logitude ?? ""
            mapImplementation()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    func mapImplementation(){
        let cordinate = CLLocationCoordinate2D(latitude: Double(latitude.asStringOrEmpty()) ?? 0.0, longitude: Double(logitude.asStringOrEmpty()) ?? 0.0)
        let region = MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapKitView.setRegion(region, animated: false)
    }
    override func draw(_ rect: CGRect) {
        mapKitView.roundCorners([.allCorners], radius: 15)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func btnMessageTapped(_ sender: Any) {
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
    }
}
