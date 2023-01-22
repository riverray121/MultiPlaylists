//
//  HomeView.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/7/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            TabBarView()
            PlayerView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
