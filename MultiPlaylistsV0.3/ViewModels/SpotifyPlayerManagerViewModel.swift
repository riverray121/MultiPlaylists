//
//  SpotifyPlayerManagerViewModel.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation
import Combine
import SwiftUI

final class SpotifyPlayerManagerViewModel: ObservableObject {
        
    @Published var isPlaying: Bool = false
    @Published var showLargePlayer: Bool = false
    @Published var playerSeekTime: Double = 60
    @Published var currentTrack: SpotifyTrack?
    
    
    func clearPlayer() {
        isPlaying = false
        playerSeekTime = 0
        currentTrack = nil
    }
    
    
    // MARK: - Control Player
    
    var apiCaller: SpotifyAPICaller = SpotifyAPICaller.shared
    
    init() {}
    

    
    public func pauseSpotify() {
        apiCaller.pausePlayback { result in
            DispatchQueue.main.async {
                if result {
                    print("success")
                } else {
                    print("failure")
                }
            }
        }
    }
    
    public func playSpotify() {
        
//        let context: String? = "spotify:album:5ht7ItJgpBH7W6vJ5BqpPr"
//        let uris: [String]? = ["spotify:track:4iV5W9uYEdYUVa79Axb7Rh", "spotify:track:1301WleyT98MSxVHPZCA6M"]
//        let offset: Int? = 5
//        let position: Int = 30000
        
        let context: String? = nil
        let uris: [String]? = nil
        let offset: Int? = nil
        let position: Int = 0
        
        apiCaller.playOrResumePlayback(context_uri: context, uris: uris, offset: offset, postion_ms: position) { result in
            DispatchQueue.main.async {
                if result {
                    print("success")
                } else {
                    print("failure")
                }
            }
        }
    }
    
    
}
