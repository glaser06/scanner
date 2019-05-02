//
//  ShowFileVCMapDelegate.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/30/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation
import MapKit

extension ShowFileViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: LocationAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: LocationAnnotationView.identifier) as? LocationAnnotationView
        if annotationView == nil {
            annotationView = LocationAnnotationView(annotation: annotation, reuseIdentifier: LocationAnnotationView.identifier)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
}
