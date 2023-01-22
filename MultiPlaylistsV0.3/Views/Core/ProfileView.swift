//
//  ProfileView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var mainAuthenticationModel: MainAuthManager
    @EnvironmentObject var soundCloudAuthenticationModel: SoundCloudAuthManager
    @EnvironmentObject var spotifyAuthManager: SpotifyAuthManager
    
    @StateObject var vm = SpotifyProfileViewModel()
    
    var body: some View {
        
        let imageUrl = vm.currentUser?.images?.first?.url ?? ""
        
        return VStack {
            
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(height: 120, alignment: .center)
            
            Text(vm.currentUser?.displayName ?? "")
                .foregroundColor(.black)
                .font(.title2)
                .bold()
                        
            Button(action: {
                SoundCloudAuthManager.shared.signOut { result in print("logout Clicked")
            }}) {
                Group {
                    if mainAuthenticationModel.soundCloudAuthenticationState == .authenticated {
                        Text("Logout of SoundCloud")
                    } else {
                        Text("SoundCloud logged out")
                    }
                }
                    .font(.body)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(Color.black)
                    .clipShape(Capsule())
            }
            
            Button(action: {
                SpotifyAuthManager.shared.signOut { result in print("logout Clicked")
            }}) {
                Group {
                    if mainAuthenticationModel.spotifyAuthenticationState == .authenticated {
                        Text("Logout of Spotify")
                    } else {
                        Text("Spotify logged out")
                    }
                }
                    .font(.body)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.black)
                    .clipShape(Capsule())
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
