//
//  WebView.swift
//  ScripturesMap
//
//  Created by IS543 on 12/6/20.
//

import SwiftUI
import WebKit
import UIKit

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
                print(htmlString)
                uiView.loadHTMLString(htmlString, baseURL: nil)
                
            } else {
                uiView.loadHTMLString("Unknown HTML content", baseURL: nil)
                
            }
        }
    }
    
}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
