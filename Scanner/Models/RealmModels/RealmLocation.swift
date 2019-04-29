//
//  RealmLocation.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/29/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwiftLocation
import CoreLocation

//class RealmLocation: Object {
//    @objc dynamic var identifier: String = ""
//    @objc dynamic var latitude: Double = 0.0
//    @objc dynamic var longitude: Double = 0.0
//    @objc dynamic var street: String = ""
//    @objc dynamic var streetNumber: String = ""
//    @objc dynamic var city: String = ""
//    @objc dynamic var zipCode: String = ""
//    @objc dynamic var state: String = ""
//    
//    override static func primaryKey() -> String {
//        return "identifier"
//    }
//    
//    func setIdentifier() {
//        self.identifier = "\(streetNumber)+\(street)+\(city)+\(zipCode)"
//    }
//    func setLocation(coordinates: CLLocationCoordinate2D) {
//        self.latitude = coordinates.latitude
//        self.longitude = coordinates.longitude
//    }
//    
//}
//extension RealmLocation {
//    
//    convenience init(location: CLPlacemark) {
//        self.init()
//        
//        self.setLocation(coordinates: (location.location?.coordinate)!)
//        self.setIdentifier()
//    }
//    var placemark: CLPlacemark {
//        let p = CLPlacemark()
//        
//        return CLPlacemark()
//    }
//    
//}

