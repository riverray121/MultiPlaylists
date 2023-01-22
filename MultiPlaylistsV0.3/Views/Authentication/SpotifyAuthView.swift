//
//  SpotifyAuthView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import SwiftUI

struct SpotifyAuthView: View {
    
    @EnvironmentObject var authManager: SpotifyAuthManager
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        SpotifyWebUIView(requestURL: authManager.signInUrlRequest) { code in
            authManager.fetchAuthResponse(using: code)
            self.presentation.wrappedValue.dismiss()
        }
    }
    
}

struct SpotifyAuthView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyAuthView()
    }
}
