//
//  LocationViewController.swift
//  HelpyService
//
//  Created by mac on 30/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import MapKit

public typealias locationPosition = (latitude: Double, longitude: Double)

struct locationAddress {
    let address: String
    let pinCode: String
    let landMark: String
    let city: String
    let state: String
}

protocol LocationDelegate {
    func location(_ locationViewController: UIViewController, didFinishPicking location: locationPosition, with Address: locationAddress?)
}


class LocationViewController: UIViewController {
    
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    
    private var centerMapCoordinate : CLLocationCoordinate2D!
    private let locationManager = CLLocationManager()
    private var currentLocation : locationPosition? = nil
    
    var delegate : LocationDelegate?
    var preferedLocation: locationPosition? {
        didSet {
            setUpMapLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponents()
    }
    
    private func setUpComponents() {
        setUpNavigationBar()
        setUpLocationManager()
        setUpMap()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func setUpMap() {
        mapKitView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setUpMapLocation()
        }
    }
    
    private func setLocation(from: locationPosition) {
        let cordinate = CLLocationCoordinate2D(latitude: from.latitude, longitude: from.longitude)
        let region = MKCoordinateRegion(center: cordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapKitView.setRegion(region, animated: false)
    }
    
    private func setUpMapLocation() {
        if let location = preferedLocation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.setLocation(from: location)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let currentLocation = self.currentLocation {
                    self.setLocation(from: currentLocation)
                }
            }
        }
    }
    
    private func setUpNavigationBar() {
        setGradient_Nav()
        Set_navigationBar(Title: "Location",isneedback: false)
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
        cancelButton.tintColor = .white
        self.navigationItem.leftBarButtonItem  = cancelButton
    }
    
    @objc private func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pickButtonClicked(_ sender: Any) {
        
        let location = (centerMapCoordinate.latitude,centerMapCoordinate.longitude)
        MapReverseGeoCode.geocode(for: location) { placeMarks, error in
            
            if let placeMark = placeMarks?.first {
                let address = placeMark.name.asStringOrEmpty()
                let pinCode = placeMark.postalCode.asStringOrEmpty()
                let landMark = placeMark.subLocality.asStringOrEmpty()
                let city = placeMark.locality.asStringOrEmpty()
                let state = placeMark.country.asStringOrEmpty()
                let addressDetail = locationAddress(address: address, pinCode: pinCode, landMark: landMark, city: city, state: state)
                self.delegate?.location(self, didFinishPicking: location, with: addressDetail)
            } else {
                self.delegate?.location(self, didFinishPicking: location, with: nil)
            }
            
            self.cancelButtonClicked()
        }
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        currentLocation = (mapView.region.center.latitude,mapView.region.center.longitude)
        centerMapCoordinate = CLLocationCoordinate2D(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
    }
}

