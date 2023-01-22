//
//  SoundCloudAuthView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import SwiftUI

struct SoundCloudAuthView: View {
    
    @Environment(\.presentationMode) var presentation
    
    private var onLogin: (String, Date?) -> ()
    
    var body: some View {
        
        SoundCloudWebUIView(url: URL(string: "https://soundcloud.com/signin")!)
            .cookie(name: "oauth_token") { cookie in
                onLogin(cookie.value, cookie.expiresDate)
                self.presentation.wrappedValue.dismiss()
            }
        
    }
    
    init(onLogin: @escaping (String, Date?) -> ()) {
        self.onLogin = onLogin
    }
    
}
