//
//  ContentView.swift
//  ScripturesMap
//
//  Created by IS543 on 11/24/20.
//

import SwiftUI
//import UIKit
//import WebKit
//import MapKit

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        NavigationView{
            List{
                ForEach(GeoDatabase.shared.volumes()){ volume in
                    NavigationLink(volume.getFullName(), destination: ScriptureBrowser(volumeBook: volume))
                }
            }
            .navigationTitle("Scriptures")
//            Map(coordinateRegion: $region)
//            MapViewPro()

        }

    }
}

//class mapData: ObservableObject{
//    //change to current location once is done//
//    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    @Published var geoPlaces:[GeoPlace] = []
//
//    func getGeoLocations()->[GeoPlace]{
//        return geoPlaces
//    }
//
//}
//struct MapViewPro: View {
//    @EnvironmentObject var mapD: mapData
//    var body: some View{
//        Map(coordinateRegion: $mapD.region)
//    }
//
//}

//struct ScriptureBrowser: View{
//    var volumeBook: Book
////    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//
//    var body: some View{
//        GeometryReader {g in
//            List{
//                ForEach(GeoDatabase.shared.booksForParentId(volumeBook.id)){ singleBook in
//                    NavigationLink(singleBook.getFullName(), destination: Volumebrowser(book: singleBook))
//                }
//            }
//        }
//        .navigationTitle(volumeBook.getFullName())
////        Map(coordinateRegion: $region)
//
//    }
//}
//struct Volumebrowser: View{
//    var book: Book
////    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    var body: some View{
//        List{
////            ForEach ( book.get_RangeOfChapter(), id: \.self){chapter in
//            ForEach(book.get_RangeOfChapter(), id: \.self){chapter in
//
//                if chapter != "0" {
////                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!)))
//                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: getViewModel(book.id, Int(chapter)!)))
//
//                }
//                else{
////                    Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!))
//                    Chaptersbrowser(geoViewModel: getViewModel(book.id, Int(chapter)!))
//                    
//                }
//            }
//        }
//        .navigationTitle(book.getFullName())
////        Map(coordinateRegion: $region)
//
//    }
//    private func getViewModel(_ bookid: Int, _ chapterid: Int) -> GeoViewModel{
//        let viewModel = GeoViewModel(bookid: bookid, chapterId: chapterid)
//        viewModel.navigationToChapter(bookId: bookid, chapter: chapterid )
//        return viewModel
//    }
//}
//struct Chaptersbrowser: View{
////    var bookId: Int
////    var chapterId: Int
////    var bookName: String = "Default"
//    @ObservedObject var geoViewModel: GeoViewModel
//    var book: Book {
//        GeoDatabase.shared.bookForId(geoViewModel.bookId)
//    }
//
////    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//
////    func newData() -> String{
////        let htmlS = ScriptureRenderer.shared
////        let geoplcs = GeoDatabase.shared.geoPlacesForScriptureBookId(bookId: bookId, chapter: chapterId)
//////        htmlS.injectGeoPlaceCollector(collector!)
////        let htmlString = htmlS.htmlForBookId(bookId, chapter: chapterId)
////        return htmlString
////    }
//    var body: some View{
//
//        if geoViewModel.chapter > 0{
//            VStack{
//                MapView(geoViewModel: geoViewModel)
//
//                WebView(request: nil, html: geoViewModel.html)
//            }
//            .navigationTitle(title())
//        }
//        else{
//            WebView(request: nil, html: geoViewModel.html)
//                .navigationTitle(title())
//        }
////        if String(chapterId) != "0"{
////
////            VStack{
////                Map(coordinateRegion: $region)
////                WebView(request: nil, html: )
////            }
////            .navigationTitle("Chapter \(chapterId)")
////        }
////        else{
////            WebView(request: nil, html: newData())
////                .navigationTitle("\(bookName)")
////        }
//
//    }
//    private func title()-> String {
//        if geoViewModel.chapter > 0{
//            return "\(book.fullName) \(geoViewModel.chapter)"
//        } else{
//            return book.fullName
//        }
//
//
//    }
//
//}

//struct WebView : UIViewRepresentable {
//    let request: URLRequest?
//    let html: String?
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if let urlRequest = request {
//            uiView.load(urlRequest)
//                
//        }else {
//            if let htmlString = html {
//                print(htmlString)
//                uiView.loadHTMLString(htmlString, baseURL: nil)
//                
//            } else {
//                uiView.loadHTMLString("Unknown HTML content", baseURL: nil)
//                
//            }
//        }
//    }
//    
//}

//struct MapView: UIViewRepresentable {
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
