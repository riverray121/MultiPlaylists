//
//  PlayerView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import SwiftUI
import WebKit

struct PlayerView: View {
    
    @EnvironmentObject var pm: SpotifyPlayerManagerViewModel
    
    var body: some View {
        showMiniPlayer()
    }
    
    private func showMiniPlayer() -> some View {
        
        return ZStack{
            Color.black.opacity(0.8)
                .cornerRadius(5)
            HStack(alignment: .center) {
                
                SpotifyWebPlayerView(request: URLRequest(url: URL(string: "https://multiplaylists.herokuapp.com")!))
//                    .frame(height:300)
                
//                Spacer()
                
                Button(action: {
                    pm.isPlaying.toggle()
                    if pm.isPlaying {
                        pm.playSpotify()
                    } else {
                        pm.pauseSpotify()
                    }
                }) {
                    Image(systemName: pm.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.horizontal,20)
                
            }
            .padding(.horizontal, 2)
        }
        .padding(.horizontal,5)
        .frame(height: 80, alignment: .center)
        .padding(.bottom,50)
    }
    
}

struct SpotifyWebPlayerView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        prefs.preferredContentMode = .desktop
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
//        uiView.evaluateJavaScript("document.getElementsByID('token')[0].value = '9999999999999999';") { (result, error) in
//            if let error = error {
//                print(error)
//            }
//        }
    }
    
}


//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView()
//    }
//}
