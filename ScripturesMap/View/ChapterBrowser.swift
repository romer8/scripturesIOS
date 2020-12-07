//
//  ChapterBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI

struct Chaptersbrowser: View{
    @ObservedObject var geoViewModel: GeoViewModel
    var book: Book {
        GeoDatabase.shared.bookForId(geoViewModel.bookId)
    }
    var body: some View{
        mapOrNot(title: title(), geoModel: geoViewModel)
        
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

extension View {
    func mapOrNot (title:String, geoModel: GeoViewModel) -> some View{
        self.modifier(mapModifier(singleTitle: title, geoModel: geoModel))
    }

}
struct mapModifier: ViewModifier {
    @State var singleTitle: String
    @State var geoModel: GeoViewModel
    func body(content: Content) -> some View {
        return VStack{
            if geoModel.chapter > 0 && isBookOfMormon(bookId: geoModel.bookId) == false {
                MapView2(geoViewModel: geoModel)
                WebView(request: nil, html: geoModel.html)
                    .injectNavigationHandler { geoPlaceId in
                        let myGeoPlace = geoModel.getGeoPlaceFromGeoId(geoId: geoPlaceId)
                        geoModel.zoomToGeoPlace(geoplace: myGeoPlace)
                        print(myGeoPlace.latitude)
                    }
            }
            else{
               WebView(request: nil, html: geoModel.html)
            }
        }
        .navigationTitle(singleTitle)
    }
    private func isBookOfMormon(bookId: Int) -> Bool{
        if (bookId < 201 || bookId > 219) {
         print("flase")
         return false
        }
        else {
            return true
        }
        
    }
}
