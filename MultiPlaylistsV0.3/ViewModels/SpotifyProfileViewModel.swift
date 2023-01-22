//
//  SpotifyProfileViewModel.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation
import SwiftUI

class SpotifyProfileViewModel: ObservableObject {
    
    @Published var currentUser: SpotifyUserProfile?

    var apiCaller: SpotifyAPICaller = SpotifyAPICaller.shared
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        apiCaller.getCurrentUserProfile {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.currentUser = model
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
           
        }
    }
}
