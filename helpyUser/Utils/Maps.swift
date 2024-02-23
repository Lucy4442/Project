//
//  Maps.swift
//  HelpyService
//
//  Created by mac on 11/12/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import MapKit

struct MapReverseGeoCode {
    
    
    static func geocode(for location: locationPosition, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { placemark, error in
            guard let placemark = placemark, error == nil else {
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    

}





