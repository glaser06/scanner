//
//  LocationRecord.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/29/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import SwiftLocation
import RealmSwift
import CoreLocation

class LocationRecord {
    
    var identifier: String = ""
    var coordinate: CLLocationCoordinate2D
    var placemark: CLPlacemark?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    init(coordinate: CLLocationCoordinate2D, place: CLPlacemark) {
        self.coordinate = coordinate
        self.placemark = place
    }
    
}
extension LocationRecord {
    convenience init(realmLocation: RealmLocation) {
        self.init(coordinate: CLLocationCoordinate2D(latitude: realmLocation.latitude, longitude: realmLocation.longitude))
        self.identifier = realmLocation.identifier
        
        
        
    }
    var realmLocation: RealmLocation {
        return RealmLocation(location: self)
    }
}
