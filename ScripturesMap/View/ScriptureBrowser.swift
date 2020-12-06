//
//  ScriptureBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI

struct ScriptureBrowser: View{
    var volumeBook: Book
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View{
        GeometryReader {g in
            List{
                ForEach(GeoDatabase.shared.booksForParentId(volumeBook.id)){ singleBook in
                    NavigationLink(singleBook.getFullName(), destination: Volumebrowser(book: singleBook))
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
