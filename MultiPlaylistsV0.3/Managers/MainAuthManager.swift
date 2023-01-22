//
//  MainAuthManager.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation


enum ServiceAuthenticationState: String, Equatable {
    case authenticated
    case unauthenticated
}


final class MainAuthManager: ObservableObject {
    
    static let shared = MainAuthManager()
        
    @Published var spotifyAuthenticationState: ServiceAuthenticationState = {
        SpotifyAuthManager.shared.isSignedIn ? .authenticated : .unauthenticated
    }()
    
    @Published var soundCloudAuthenticationState: ServiceAuthenticationState = {
        SoundCloudAuthManager.shared.isSignedIn ? .authenticated : .unauthenticated
    }()
    
    @Published var generalAuthenticationState: ServiceAuthenticationState = {
        SoundCloudAuthManager.shared.isSignedIn || SpotifyAuthManager.shared.isSignedIn ? .authenticated : .unauthenticated
    }()
    
    func updateGeneralAuthState() {
        if soundCloudAuthenticationState == .authenticated || spotifyAuthenticationState == .authenticated {
            generalAuthenticationState = .authenticated
        } else {
            generalAuthenticationState = .unauthenticated
        }
    }
    
}
