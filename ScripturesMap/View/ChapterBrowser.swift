//
//  ChapterBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI

struct Chaptersbrowser: View{
//    var bookId: Int
//    var chapterId: Int
//    var bookName: String = "Default"
    @ObservedObject var geoViewModel: GeoViewModel
    var book: Book {
        GeoDatabase.shared.bookForId(geoViewModel.bookId)
    }
    
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
//    func newData() -> String{
//        let htmlS = ScriptureRenderer.shared
//        let geoplcs = GeoDatabase.shared.geoPlacesForScriptureBookId(bookId: bookId, chapter: chapterId)
////        htmlS.injectGeoPlaceCollector(collector!)
//        let htmlString = htmlS.htmlForBookId(bookId, chapter: chapterId)
//        return htmlString
//    }
    var body: some View{

        if geoViewModel.chapter > 0{
            VStack{
                MapView2(geoViewModel: geoViewModel)
                
                WebView(request: nil, html: geoViewModel.html)
            }
            .navigationTitle(title())
        }
        else{
            WebView(request: nil, html: geoViewModel.html)
                .navigationTitle(title())
        }
//        if String(chapterId) != "0"{
//
//            VStack{
//                Map(coordinateRegion: $region)
//                WebView(request: nil, html: )
//            }
//            .navigationTitle("Chapter \(chapterId)")
//        }
//        else{
//            WebView(request: nil, html: newData())
//                .navigationTitle("\(bookName)")
//        }

    }
    private func title()-> String {
        if geoViewModel.chapter > 0{
            return "\(book.fullName) \(geoViewModel.chapter)"
        } else{
            return book.fullName
        }
        
        
    }

}

//struct ChapterBrowser_Previews: PreviewProvider {
//    static var previews: some View {
//        ChapterBrowser()
//    }
//}
