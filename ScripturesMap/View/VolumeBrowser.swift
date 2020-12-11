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
    @ObservedObject var geoViewModel:  GeoViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View{
        GeometryReader{ geom in
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(book.get_RangeOfChapter(), id: \.self){chapter in
                    if chapter != "0" {
                        ZStack{
                            Rectangle()
                                .strokeBorder(Color.blue.opacity(0.5),lineWidth: 2)
                            NavigationLink("\(chapter)",
                                           destination: Chaptersbrowser(geoViewModel:
                                                                            geoViewModel)
                                            .onAppear{
                                                geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                                geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                                geoViewModel.setGeocodedPlaces(ScriptureRenderer.shared.geoPlaces(for: book, chapter: geoViewModel.chapter))

                                            }.onDisappear{
                                                geoViewModel.geoPlaces = []
                                            }).isDetailLink(false)

                        }
                        
                    }
                    else{
                            Chaptersbrowser(geoViewModel:geoViewModel)
                                .onAppear{
                                    geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                    geoViewModel.navigationToChapter(bookId: book.id, chapter: Int(chapter)!)
                                    geoViewModel.setGeocodedPlaces(ScriptureRenderer.shared.geoPlaces(for: book, chapter: geoViewModel.chapter))

                                }.onDisappear{
                                    geoViewModel.geoPlaces = []

                                }
                                .frame(width:geom.size.width * 0.9 , height:geom.size.height , alignment: .center)


                    }
                }
            }
            .navigationTitle(book.getFullName())

        }
    }
    

}

