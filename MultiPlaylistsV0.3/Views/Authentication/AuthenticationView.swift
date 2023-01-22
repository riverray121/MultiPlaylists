//
//  AuthenticationView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/7/23.
//

import SwiftUI
import Combine
import SoundCloud

struct AuthenticationView: View {
    
    @EnvironmentObject var mainAuthenticationModel: MainAuthManager
    @EnvironmentObject var soundCloudAuthenticationModel: SoundCloudAuthManager
    @EnvironmentObject var spotifyAuthManager: SpotifyAuthManager
    
    @Binding var userIsInSetup: Bool
        
    var body: some View {
        
        NavigationStack {
            
            Spacer()
            Text("Please link the servies you would like to use")
            Spacer()
            if mainAuthenticationModel.soundCloudAuthenticationState == .authenticated {
                Button(action: {
                    SoundCloudAuthManager.shared.signOut { result in print("logout Clicked")
                }}) {
                    Text("Logout of SoundCloud")
                        .font(.body)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(Color.black)
                        .clipShape(Capsule())
                }
            } else {
                soundCloudAuthButtonView
            }
            Spacer()
            if mainAuthenticationModel.spotifyAuthenticationState == .authenticated {
                Button(action: {
                    SpotifyAuthManager.shared.signOut { result in print("logout Clicked")
                }}) {
                    Text("Logout of Spotify")
                        .font(.body)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .clipShape(Capsule())
                }
            } else {
                spotifyAuthButtonView
            }
            Spacer()
            Button(action: {
                userIsInSetup = false
                print("Done Linking Services")
            }) {
                Text("Continue")
                    .padding()
            }
            .disabled(mainAuthenticationModel.generalAuthenticationState == .unauthenticated)
            
        }
        
    }
    
    private var soundCloudAuthButtonView: some View {
        NavigationLink(destination: SoundCloudAuthView { accessToken, expiryDate in
            SoundCloudUserDefaultsHelper.setData(value: accessToken, key: .scAccessToken)
            SoundCloudUserDefaultsHelper.setData(value: expiryDate, key: .scAccessTokenExpiryDate)
            SoundCloud.shared.accessToken = accessToken
            MainAuthManager.shared.soundCloudAuthenticationState = .authenticated
            MainAuthManager.shared.updateGeneralAuthState()
        }
            .navigationTitle("Link SoundCloud"))
        {
            Text("Link SoundCloud Account")
                .font(.body)
                .padding()
                .background(Color.orange)
                .foregroundColor(Color.black)
                .clipShape(Capsule())
        }
    }
    
    
    private var spotifyAuthButtonView: some View {
        NavigationLink(destination: SpotifyAuthView()
            .navigationTitle("Link Spotify"))
        {
            Text("Link Spotify Account")
                .font(.body)
                .padding()
                .background(Color.green)
                .foregroundColor(Color.black)
                .clipShape(Capsule())
        }
    }
    
    
    
    
    private var serviceAuthenticationView: some View {
        
        HStack {
            Text("Service Name")
            Spacer()
            Text("Auth Status")
            Spacer()
            Text("Authenticate / Log Out")
        }
        
    }
    
}
