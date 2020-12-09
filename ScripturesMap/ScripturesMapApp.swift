//
//  ScripturesMapApp.swift
//  ScripturesMap
//
//  Created by IS543 on 11/24/20.
//

import SwiftUI

@main
struct ScripturesMapApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(geoViewModel: GeoViewModel(bookid: 101, chapterId: 1))
            
        }
    }
}
