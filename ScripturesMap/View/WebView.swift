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
    private let coordinator = Coordinator()
    func injectNavigationHandler(_ handler: @escaping (Int) -> Void) -> some View{
        coordinator.navigationHandler = handler
        
        return self
    }
    func makeCoordinator() -> Coordinator {
        coordinator
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = coordinator
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlRequest = request {
            uiView.load(urlRequest)
        }else {
            if let htmlString = html {
                uiView.loadHTMLString(htmlString, baseURL: nil)
                
            } else {
                uiView.loadHTMLString("Unknown HTML content", baseURL: nil)
                
            }
        }
    }
    class Coordinator: NSObject, WKNavigationDelegate {
        var navigationHandler: ((Int) -> Void)? = nil
        func webView(_ webWiew: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
            if let url = navigationAction.request.url {
                if url.absoluteString.starts(with: WebView.placeUrl){
                    decisionHandler(.cancel)
                    
                    if let handler = navigationHandler{
                        let geoPlacedId = Int(url.absoluteString.substring(fromOffset: WebView.placeUrl.count)) ?? 0
                        handler(geoPlacedId)
                    }
                    return
                }
            }
            
            decisionHandler(.allow)
            
        }
    }
    static let placeUrl = "https://scriptures.byu.edu/mapscrip/"
    
}
