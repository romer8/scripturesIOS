//
//  ContentView.swift
//  ScripturesMap
//
//  Created by IS543 on 11/24/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var geoViewModel:  GeoViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
//        GeometryReader{ g in
                NavigationView{
                        ForEach(GeoDatabase.shared.volumes()){ volume in
                            Section(header: Text(volume.getFullName()).fontWeight(.bold)){
                                LazyVGrid(columns: columns,
                                          alignment: .center,
                                          spacing:3,
                                          pinnedViews: [.sectionHeaders, .sectionFooters]){
                                    ForEach(GeoDatabase.shared.booksForParentId(volume.id)){ singleBook in
                                        ZStack{
                                            Rectangle()
                                                .strokeBorder(Color.blue.opacity(0.5),lineWidth: 2)
                                
                                            NavigationLink(singleBook.gridName, destination:
                                                            Volumebrowser(book: singleBook, geoViewModel: geoViewModel)
                                                            .background(Color.gray.opacity(0.2))

                                                            .onAppear{
                                                                 geoViewModel.showAll = false
                                                                 geoViewModel.mapRegion = MKCoordinateRegion(
                                                                     center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
                                                                     span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                                                                 )
                                                             }
                                            )
                                            .isDetailLink(false)
                                        }
                                    }
                                }

                            }
                        }
                    .navigationBarTitle("Scriptures",displayMode: .large)
                    MapDetailView(geoViewModel:geoViewModel).edgesIgnoringSafeArea(.all)
            }
            .background(Color.gray.opacity(0.2))

    }
}
struct MapDetailView: View {
    @ObservedObject var geoViewModel: GeoViewModel
    var body: some View {
        GeometryReader { geometry in
            MapView2(geoViewModel: geoViewModel)
                .onAppear {
                    geoViewModel.isDetailVisible = geometry.frame(in: .global).maxY > 0
                }
        }
    }
}
