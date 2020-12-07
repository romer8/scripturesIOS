//
//  MapView.swift
//  ScripturesMap
//
//  Created by IS543 on 12/4/20.
//

import SwiftUI
import MapKit
import UIKit


struct MapView: View {
    @ObservedObject var geoViewModel: GeoViewModel
//    @State private var mapRegion = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
//        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//    )
    var body: some View {
        Map(coordinateRegion: $geoViewModel.mapRegion,
            annotationItems: geoViewModel.geoPlaces){ geoPlace in
            MapAnnotation(coordinate: CLLocationCoordinate2D(
                latitude: geoPlace.latitude,
                longitude: geoPlace.longitude),
                          anchorPoint: CGPoint(x: 0.5, y:0.5)){
                Image(systemName: "mappin")
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 0.75, green: 0.1, blue: 0.1))
                    .shadow(radius: 1, x:1, y:1)

            }
            }

    }
}


struct MapView2: UIViewRepresentable {
//    @Binding var centerCoordinate: CLLocationCoordinate2D
    @ObservedObject var geoViewModel: GeoViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView2 = MKMapView()
        mapView2.delegate = context.coordinator
        print("NOOO")
        geoViewModel.makeNewCenter()
        mapView2.setRegion(geoViewModel.mapRegion, animated: true)

        return mapView2
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.setRegion(geoViewModel.mapRegion, animated: true)
        if geoViewModel.geoPlaces.count != view.annotations.count {
//            geoViewModel.makeNewCenter()

            view.removeAnnotations(view.annotations)
            view.addAnnotations(geoViewModel.makeAnnotations())
//            view.fitAll()
            view.showAnnotations(geoViewModel.makeAnnotations(), animated: true)
        }
        

    
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView2

        init(_ parent: MapView2) {
            self.parent = parent
        }
//        func mapViewDidChangeVisibleRegion(_ mapView2: MKMapView) {
//            parent.geoViewModel.mapRegion.center = mapView2.centerCoordinate
//        }
    }
}
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
