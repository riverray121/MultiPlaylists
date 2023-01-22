//
//  SoundCloudWebUIView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import SwiftUI
import WebKit
import Combine

typealias scCookieHandler = ((HTTPCookie) -> ())

struct SoundCloudWebUIView: UIViewRepresentable {
    
    private var url: URL
    private var coordinator = SCWebUIViewCoordinator()

    init(url: URL) {
        self.url = url
    }
    
    func makeCoordinator() -> SCWebUIViewCoordinator {
        return coordinator
    }
    
    func makeUIView(context: Self.Context) -> WKWebView {
        let conf = WKWebViewConfiguration()
        conf.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        prefs.preferredContentMode = .desktop
        conf.defaultWebpagePreferences = prefs
        let view = WKWebView(frame: .zero, configuration: conf)
        view.load(URLRequest(url: url))
        view.navigationDelegate = context.coordinator
        view.scrollView.isScrollEnabled = false
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func cookie(name: String, handler: @escaping scCookieHandler) -> SoundCloudWebUIView {
        coordinator.handlers.append((name, handler))
        return self
    }
    
}


class SCWebUIViewCoordinator: NSObject, WKNavigationDelegate {
    
    var handlers = [(String, scCookieHandler)]()
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        webView.scrollView.contentOffset = CGPointMake(300, 0)
//        print(webView.scrollView.contentOffset)
//        print(webView.scrollView.contentSize)
        let store = webView.configuration.websiteDataStore
        store.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                for (name, handler) in self.handlers {
                    if name == cookie.name {
                        handler(cookie)
                        print("GOT COOKIE")
                    }
                }
            }
        }
        decisionHandler(.allow)
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Did start prov")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("did fail")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish")
    }
    
    
}
