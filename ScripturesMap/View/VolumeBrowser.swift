//
//  VolumeBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI

struct Volumebrowser: View{
    var book: Book
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View{
        List{
//            ForEach ( book.get_RangeOfChapter(), id: \.self){chapter in
            ForEach(book.get_RangeOfChapter(), id: \.self){chapter in

                if chapter != "0" {
//                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!)))
                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: getViewModel(book.id, Int(chapter)!)))

                }
                else{
//                    Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!))
                    Chaptersbrowser(geoViewModel: getViewModel(book.id, Int(chapter)!))
                    
                }
            }
        }
        .navigationTitle(book.getFullName())
//        Map(coordinateRegion: $region)

    }
    private func getViewModel(_ bookid: Int, _ chapterid: Int) -> GeoViewModel{
        let viewModel = GeoViewModel(bookid: bookid, chapterId: chapterid)
        viewModel.navigationToChapter(bookId: bookid, chapter: chapterid )
        return viewModel
    }
}

//struct VolumeBrowser_Previews: PreviewProvider {
//    static var previews: some View {
//        VolumeBrowser()
//    }
//}
