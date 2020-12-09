//
//  ScriptureBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI
import MapKit

struct ScriptureBrowser: View{
    var volumeBook: Book
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @ObservedObject var geoViewModel:  GeoViewModel

    var body: some View{
        GeometryReader {g in
            List{
                ForEach(GeoDatabase.shared.booksForParentId(volumeBook.id)){ singleBook in
                    NavigationLink(singleBook.getFullName(), destination:
                                    Volumebrowser(book: singleBook, geoViewModel: geoViewModel)
                                    .onAppear{
                                        geoViewModel.showAll = false
                                        geoViewModel.mapRegion = MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
                                            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                                        )
                                        
                                    })
                        .isDetailLink(false)
                }
            }

        }
        .navigationTitle(volumeBook.getFullName())

//        Map(coordinateRegion: $region)

    }
}
//struct ScriptureBrowser_Previews: PreviewProvider {
//    static var previews: some View {
//        ScriptureBrowser()
//    }
//}
