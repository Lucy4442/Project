//
//  HelpyLocationView.swift
//  HelpyService
//
//  Created by mac on 30/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import MapKit

public protocol NibInstantiatable {
    
    static func nibName() -> String
    
}

extension NibInstantiatable {
    
    static func nibName() -> String {
        return String(describing: self)
    }
    
}

extension NibInstantiatable where Self: UIView {
    
    static func instantiate() -> Self {
        let bundle = Bundle(for: self)
        let nib = bundle.loadNibNamed(nibName(), owner: self, options: nil)
        return nib!.first as! Self
    }
    
}

class HelpyLocationView: UIView,NibInstantiatable {

    // MARK: outlet
    @IBOutlet weak var mapKitView: MKMapView!
    
    // MARK: variable
    var delegate : LocationDelegate?
    var preferedLocation: locationPosition?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTapGesture()
    }

    // MARK: action
    func setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickUpLocation))
        mapKitView.isUserInteractionEnabled = true
        mapKitView.addGestureRecognizer(tapGesture)
    }
    
    func setUp(location: locationPosition) {
        let cordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapKitView.setRegion(region, animated: false)
    }
    
    @objc func pickUpLocation() {
        let locationViewController = AppStoryboard.User.viewController(viewControllerClass: LocationViewController.self)
        locationViewController.delegate = delegate
        let navController = UINavigationController(rootViewController: locationViewController)
        navController.modalPresentationStyle = .fullScreen
        locationViewController.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            locationViewController.isModalInPresentation = true
        }
        if let location = preferedLocation {
            locationViewController.preferedLocation = location
        } else {
            locationViewController.preferedLocation = nil
        }
        UIViewController().topMostViewController()?.present(navController, animated: true, completion: nil)
    }
    
}
