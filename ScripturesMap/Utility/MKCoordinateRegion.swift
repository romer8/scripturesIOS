//
//  MKCoordinateRegion.swift
//  ScripturesMap
//
//  Created by IS543 on 12/4/20.
//

import MapKit
extension MKCoordinateRegion {

  init(coordinates: [CLLocationCoordinate2D]) {
    var minLatitude: CLLocationDegrees = 90.0
    var maxLatitude: CLLocationDegrees = -90.0
    var minLongitude: CLLocationDegrees = 180.0
    var maxLongitude: CLLocationDegrees = -180.0
    var zoomFactor = 1
    if coordinates.count > 0{
        for coordinate in coordinates {
          let lat = Double(coordinate.latitude)
          let long = Double(coordinate.longitude)
          if lat < minLatitude {
            minLatitude = lat
          }
          if long < minLongitude {
            minLongitude = long
          }
          if lat > maxLatitude {
            maxLatitude = lat
          }
          if long > maxLongitude {
            maxLongitude = long
          }
        }
//        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)

        let span = MKCoordinateSpan(latitudeDelta: (maxLatitude - minLatitude) * Double(zoomFactor), longitudeDelta: (maxLongitude - minLongitude) * Double(zoomFactor))
        let center = CLLocationCoordinate2DMake((maxLatitude - span.latitudeDelta / 2), (maxLongitude - span.longitudeDelta / 2))
        self.init(center: center, span: span)

    }
    else{
        let center = CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137)
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        self.init(center: center, span: span)

    }
    





  }
}
