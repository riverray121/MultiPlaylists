//
//  SpotifyWebUIView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import SwiftUI
import WebKit

struct SpotifyWebUIView: UIViewRepresentable {
    
    var requestURL: URLRequest
    let authExchangeCode: ((String) -> Void)
        
    init(requestURL: URLRequest, authExchangeCode: @escaping (String)->Void) {
        self.requestURL = requestURL
        self.authExchangeCode = authExchangeCode
    }
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        return WKWebView(frame: .zero, configuration: config)
    }()
    
    func makeCoordinator() -> SPFYWebUIViewCoordinator {
        SPFYWebUIViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webView
    }
    
    func updateUIView(_ webUIView: WKWebView, context: Context) {
        webUIView.navigationDelegate = context.coordinator
        webUIView.load(requestURL)
    }
    
    
}


extension SpotifyWebUIView {
    
    class SPFYWebUIViewCoordinator: NSObject, WKNavigationDelegate {
        
        var parent: SpotifyWebUIView
        
        init(_ parent: SpotifyWebUIView) {
            self.parent = parent
        }
                
        func webView(_ webUIView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            guard let url = webUIView.url else {
                return
            }
            // Exchange the code for access token
            let component = URLComponents(string: url.absoluteString)
            guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else {
                return
            }
            print("exchange.code:\(code)")
            
            webUIView.isHidden = true
            parent.authExchangeCode(code)
        }
    }
}



#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        SpotifyWebUIView(requestURL: URLRequest(url: URL(string: "https://www.apple.com")!)) { code in
            print(code)
        }
    }
}
#endif
