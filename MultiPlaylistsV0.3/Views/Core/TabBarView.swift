//
//  TabBarView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "house")
                }
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
//        .edgesIgnoringSafeArea(.all)
        .overlay(
                RoundedRectangle(cornerRadius: 55)
                .stroke(lineWidth: 10)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.blue)
        )
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
