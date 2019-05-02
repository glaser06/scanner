//
//  LocationService.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/29/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

import SwiftLocation
import CoreLocation

class LocationManager {
    
    static let sharedInstance = LocationManager()
    
    var currentLocation: CLLocation?
    var currentPlace: CLPlacemark?
    var updated = false
    
    init() {
        
        Locator.currentPosition(accuracy: .room, onSuccess: { (location) -> (Void) in
            self.currentLocation = location
            if !self.updated {
                self.updated = true
//                self.updateLocation()
            }
            self.updated = true
            
            
            
            
        }, onFail: { (err, last) -> (Void) in
            print("error2",err, last)
        })
        Locator.subscribePosition(accuracy: .room, onUpdate: { (location) -> (Void) in
            self.currentLocation = location
//            if !self.updated {
//                self.updated = true
//                self.updateLocation()
//            }
            self.updated = true
            
            
        }) { (err, last) -> (Void) in
            print("errored", last)
        }
        
//        DispatchQueue.global(qos: .background).async {
//            while true {
//                self.updateLocation()
//                sleep(3)
//            }
//
//        }
//
        
        
        
        
    }
    
    func currentPlace(completion: @escaping (CLPlacemark) -> (), onError: @escaping (Error) -> ()) {
        if updated {
            Locator.location(fromCoordinates: self.currentLocation!.coordinate, locale: nil, using: GeocoderService.apple, timeout: 1.0, onSuccess: { (places) -> (Void) in
                
                if !places.isEmpty {
                    
                    if let place = places[0].placemark {
                        //                        let addressString = "\(place.subThoroughfare!) \(place.thoroughfare!)"
                        completion(place)
                    }
                    
                }
                
            }, onFail: { (err) -> (Void) in
                print("error1",err)
                onError(err)
            })
        }
        
    }
    
    
}
