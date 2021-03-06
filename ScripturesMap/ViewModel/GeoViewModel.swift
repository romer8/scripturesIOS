//
//  GeoViewModel.swift
//  ScripturesMap
//
//  Created by IS543 on 12/4/20.
//

import Foundation
import MapKit
class GeoViewModel: ObservableObject, GeoPlaceCollector{
    @Published var bookId: Int = 0
    @Published var chapter: Int = 0
    @Published var geoPlaces = [GeoPlace]()
    @Published var html: String = ""
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    )
    @Published var showAll: Bool = true
    private var scaleViewAltitute = 20000
    @Published var isDetailVisible = false

    // Mark: -Initializer
    init(bookid: Int, chapterId: Int) {
        bookId = bookid
        chapter = chapterId
    }

    // Mark: - Intents
    
    func navigationToChapter(bookId: Int, chapter:Int){
        self.bookId = bookId
        self.chapter = chapter
        html = ScriptureRenderer.shared.htmlForBookId(bookId, chapter: chapter)
        makeNewCenter()
        showAll = true
    }
    
    func makeNewCenter(){
        var coordinates: [CLLocationCoordinate2D] = []
        geoPlaces.forEach(){ geoPlace in
            coordinates.append(CLLocationCoordinate2D(
                latitude: geoPlace.latitude,
                longitude: geoPlace.longitude))
       }
        mapRegion = MKCoordinateRegion(coordinates: coordinates)

    }
    func zoomToGeoPlace(geoplace: GeoPlace){
        print(geoplace.latitude)
        print(geoplace.longitude)
        print(geoplace.viewAltitude)
        let coord = CLLocationCoordinate2D(
            latitude: geoplace.latitude,
            longitude: geoplace.longitude)
        mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: geoplace.latitude, longitude: geoplace.longitude),
            span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(Int(geoplace.viewAltitude!)/scaleViewAltitute), longitudeDelta: CLLocationDegrees(Int(geoplace.viewAltitude!)/scaleViewAltitute))
        )
        
    }
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places{
            geoPlaces = places
            geoPlaces = Array(Set(geoPlaces))
        }
    }
    func makeAnnotations() -> [MKPointAnnotation]{
        var annots: [MKPointAnnotation] = []
        for geoplace in geoPlaces{
            var annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: geoplace.latitude,
                longitude: geoplace.longitude)
            annotation.title = geoplace.placename
            annots.append(annotation)
        }
        return annots
    }
    func getGeoPlaceFromGeoId(geoId:Int) -> GeoPlace? {
        for geoplace in geoPlaces{
            if geoplace.id == geoId{
                return geoplace
            }
        }
        return GeoDatabase.shared.geoPlaceForId(geoId)
        
    }
    
    
    
    
}
