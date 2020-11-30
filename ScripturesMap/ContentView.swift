//
//  ContentView.swift
//  ScripturesMap
//
//  Created by IS543 on 11/24/20.
//

import SwiftUI
import UIKit
import WebKit
import MapKit

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            List{
                ForEach(GeoDatabase.shared.volumes()){ volume in
                    NavigationLink(volume.getFullName(), destination: ScriptureBrowser(volumeBook: volume))
                }
            }
            .navigationTitle("Scriptures")
        }

    }
}

struct ScriptureBrowser: View{
    var volumeBook: Book
    var body: some View{
        GeometryReader {g in
            List{
                ForEach(GeoDatabase.shared.booksForParentId(volumeBook.id)){ singleBook in
                    NavigationLink(singleBook.getFullName(), destination: Volumebrowser(book: singleBook))
                }
            }
        }
        .navigationTitle(volumeBook.getFullName())
    }
}
struct Volumebrowser: View{
    var book: Book
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        List{
            ForEach(book.get_RangeOfChapter(), id: \.self){chapter in
                if chapter != "0" {
                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(bookId: book.id, chapterId: Int(chapter)!))
                        .navigationTitle("Chapter \(chapter)")

                }
                else{
                    Chaptersbrowser(bookId: book.id, chapterId: Int(chapter)!)
                        .navigationTitle("\(book.getFullName())")

                }
            }
        }
        .navigationTitle(book.getFullName())

    }
}
struct Chaptersbrowser: View{
    var bookId: Int
    var chapterId: Int
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View{
        VStack{
            Map(coordinateRegion: $region)
            ScrollView(){
                VStack{
                    ForEach(GeoDatabase.shared.versesForScriptureBookId(bookId, chapterId)){verse in
                        Text(verse.text)
                    }
                }
            }
        }

        
    }

}
struct WebView : UIViewRepresentable {
    let request: URLRequest?
    let html: String?
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlRequest = request {
            uiView.load(urlRequest)
                
        }else {
            if let htmlString = html {
                uiView.loadHTMLString(htmlString, baseURL: nil)
                
            } else {
                uiView.loadHTMLString("Unknown HTML content", baseURL: nil)
                
            }
        }
        
    }
}
func webView2(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    guard
        let path = Bundle.main.path(forResource: "style", ofType: "css"),
        let cssString = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined()
    else {
        return
    }


    let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
    webView.evaluateJavaScript(jsString)
}
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
