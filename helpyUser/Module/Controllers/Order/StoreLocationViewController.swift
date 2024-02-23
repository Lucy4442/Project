//
//  StoreLocationViewController.swift
//  helpyUser
//
//  Created by mac on 21/06/21.
//

import UIKit
import GoogleMaps

class StoreLocationViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var btnZoomIn: UIButton!
    @IBOutlet weak var btnZoomOut: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgDeliveryMan: UIImageView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var storeOwnerView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnstar: UIButton!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var btnRedLocation: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var lblStars: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    var providerInfo : ServiceProviderInfo?
    var ProviderID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Set_navigationBar(Title: "Grocery Store", isneedback: true)
        GetServiceProviderInfo(booking_id: String(ProviderID))
    }
    override func viewDidLayoutSubviews() {
        imgProfile.cornerRadius = imgProfile.frame.size.width / 2
        btnZoomIn.cornerRadius = btnZoomIn.frame.size.width / 2
        btnZoomOut.cornerRadius = btnZoomOut.frame.size.width / 2
        imgProfile.roundCorners([.allCorners], radius: 20)
        storeOwnerView.roundCorners([.allCorners], radius: 20)
        storeView.roundCorners([.topLeft, .topRight], radius: 20)
        btnNext.roundCorners([.allCorners], radius: 20)
    }
    func GetServiceProviderInfo(booking_id: String) {
        LoaderManager.showLoader()
        APIManager.share.GetServiceProviderInfo(booking_id: booking_id) { (Result) in
            LoaderManager.hideLoader()
            switch Result {
            case .success(let response):
                self.providerInfo = response
                self.SetUpAPIData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    func SetUpAPIData(){
        mapImplementation()
        lblname.text = providerInfo?.data?.name
        lblStars.text = "4/5"
        lblLocation.text = providerInfo?.data?.address
        imgProfile.getImage(url: providerInfo?.data?.avatar ?? "", placeholderImage: ImageName.Placeholder)
    }
    func mapImplementation(){
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude:-122.0, zoom: 10)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        //mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true;
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
        marker.groundAnchor = CGPoint(x: 0, y: 0)
        marker.title = "Bangladesh"
        marker.map = mapView
        let rect = GMSMutablePath()
        rect.add(CLLocationCoordinate2D(latitude: 37.36 - 0.05, longitude: -121.5))
        rect.add(CLLocationCoordinate2D(latitude: 37.36 + 0.05, longitude: -121.5))
        rect.add(CLLocationCoordinate2D(latitude: 37.36 + 0.05, longitude: -122.1))
        rect.add(CLLocationCoordinate2D(latitude: 37.36 - 0.05, longitude: -122.1))
//        let strokeStyles = [GMSStrokeStyle.solidColor(UIColor.App_LightBlue ?? UIColor()), GMSStrokeStyle.solidColor(.clear)]
//        let strokeLengths = [NSNumber(value: 100), NSNumber(value: 100)]
//        let poly = GMSPolyline(path: rect)
//        if let path = poly.path {
//            poly.spans = GMSStyleSpans(path, strokeStyles, strokeLengths, .geodesic)
//        }
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor.App_SemiBlue
        polygon.strokeColor = UIColor.App_LightBlue ?? UIColor()
        polygon.map = mapView
       // poly.map = mapView
    }
}
