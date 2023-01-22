//
//  WelcomeView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/7/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var viewSeen: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Welcome to MultiPlaylists")
            Spacer()
            Spacer()
            Button(action: {
                viewSeen = true
            }) {
                Text("Begin Setup")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.black)
                    .clipShape(Capsule())
            }
        }
    }
}

//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//    }
//}
