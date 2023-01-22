//
//  MultiPlaylistsV0_3App.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/7/23.
//

import SwiftUI

@main
struct MultiPlaylistsV0_3App: App {
    
    // State Object so that it will at no point be destroyed by the application
    @StateObject var mainAuthenticationModel: MainAuthManager = MainAuthManager.shared
    @StateObject var soundCloudAuthenticationModel: SoundCloudAuthManager = SoundCloudAuthManager.shared
    @StateObject var spotifyAuthenticationModel: SpotifyAuthManager = SpotifyAuthManager.shared
    @StateObject var spotifyPlayerVM: SpotifyPlayerManagerViewModel = SpotifyPlayerManagerViewModel()

    @State var userIsInSetup: Bool = false
    @State var welcomeViewSeen: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch mainAuthenticationModel.generalAuthenticationState {
                case .authenticated:
                    if userIsInSetup {
                        AuthenticationView(userIsInSetup: $userIsInSetup)
                    } else {
                        HomeView()
                            .environmentObject(spotifyPlayerVM)
                    }
                case .unauthenticated:
                    if !welcomeViewSeen {
                        WelcomeView(viewSeen: $welcomeViewSeen)
                    } else {
                        AuthenticationView(userIsInSetup: $userIsInSetup)
                            .onAppear {
                                userIsInSetup = true
                            }
                    }
                }
            }
            .environmentObject(spotifyAuthenticationModel)
            .environmentObject(mainAuthenticationModel)
            .environmentObject(soundCloudAuthenticationModel)
            .onAppear {
#if DEBUG
                UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
#endif
            }
        }
    }
    
}
