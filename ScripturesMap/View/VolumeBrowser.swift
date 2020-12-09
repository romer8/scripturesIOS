//
//  VolumeBrowser.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI
import MapKit
struct Volumebrowser: View{
    var book: Book
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @ObservedObject var geoViewModel:  GeoViewModel

    var body: some View{
        List{
//            ForEach ( book.get_RangeOfChapter(), id: \.self){chapter in
            ForEach(book.get_RangeOfChapter(), id: \.self){chapter in

                if chapter != "0" {
//                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!)))
                    NavigationLink("Chapter \(chapter)",
                                   destination: Chaptersbrowser(geoViewModel:
                                                                    geoViewModel).onAppear{
                                                                        geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                                                        geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                                                    }).isDetailLink(false)

//                                                                        .onAppear{
//                                                                        geoViewModel.mapRegion = MKCoordinateRegion(
//                                                                            center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
//                                                                            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//                                                                        )
//                                                                        
//                                                                    }
                                    

//                    NavigationLink("Chapter \(chapter)", destination: Chaptersbrowser(geoViewModel: geoViewModel,bookid: book.id, chapter:Int(chapter)!))
//                        .onAppear{
//                            geoViewModel.fakeInit(bookId: book.id, chapter: Int(chapter)!)
//                            geoViewModel.navigationToChapter( bookId: book.id,chapter: Int(chapter)!)
//                        }


                }
                else{
//                    Chaptersbrowser(geoViewModel: GeoViewModel(bookid: book.id, chapterId: Int(chapter)!))
//                    Chaptersbrowser(geoViewModel: geoViewModel.fakeInit(bookId: book.id, chapter: Int(chapter)!))
                    Chaptersbrowser(geoViewModel:geoViewModel)
                        .onAppear{
                            geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                            geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                                     }
//                    Chaptersbrowser(geoViewModel: geoViewModel)
//                    Chaptersbrowser(geoViewModel: geoViewModel,bookid: book.id, chapter:Int(chapter)!)
//                        .onAppear{
//                            geoViewModel.fakeInit(bookId: book.id, chapter: Int(chapter)!)
//                            geoViewModel.navigationToChapter( bookId: book.id,chapter: Int(chapter)!)
//                        }
//                    Chaptersbrowser(geoViewModel: geoViewModel.fakeInit(bookId: book.id, chapter: Int(chapter)!))


                    
                }
            }
        }
        .navigationTitle(book.getFullName())

//        Map(coordinateRegion: $region)

    }
//    private func getViewModel(_ bookid: Int, _ chapterid: Int) -> GeoViewModel{
//        let viewModel = GeoViewModel(bookid: bookid, chapterId: chapterid)
//        viewModel.navigationToChapter(bookId: bookid, chapter: chapterid )
////        geoViewModel = viewModel
//        return viewModel
//    }
}

//struct VolumeBrowser_Previews: PreviewProvider {
//    static var previews: some View {
//        VolumeBrowser()
//    }
//}
