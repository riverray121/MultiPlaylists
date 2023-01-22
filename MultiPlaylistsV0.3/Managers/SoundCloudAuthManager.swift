//
//  SoundCloudAuthManager.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation
import Combine
import SoundCloud


final class SoundCloudAuthManager: ObservableObject {
    
    static let shared = SoundCloudAuthManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let accessTokenKey = "scAccessToken"
    private let accessTokenExpiryDateKey = "scAccessTokenExpiryDate"
    private let userKey = "scUser"
    
    
    private init() {
        soundCloudSetUp()
    }
    
    
    private func soundCloudSetUp() {
        let size = 500*1024*1024
        URLCache.shared = URLCache(memoryCapacity: size, diskCapacity: size)
        URLSession.shared.configuration.requestCachePolicy = .returnCacheDataElseLoad
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: userKey) {
            SoundCloud.shared.user = try? JSONDecoder().decode(User.self, from: data)
        }
        let token = defaults.object(forKey: accessTokenKey)
        let expiryDate = defaults.object(forKey: accessTokenExpiryDateKey)
        if let token = token as? String {
            if let exipryDate = expiryDate as? Date, exipryDate < Date() {
                defaults.set(nil, forKey: accessTokenKey)
                defaults.set(nil, forKey: accessTokenExpiryDateKey)
            }
            else {
                SoundCloud.shared.accessToken = token
            }
        }
        SoundCloud.shared.$user.sink { user in
            if let user = user {
                let data = try? JSONEncoder().encode(user)
                defaults.set(data, forKey: self.userKey)
            }
            else {
                defaults.set(nil, forKey: self.userKey)
            }
        }
        .store(in: &subscriptions)
    }
    
    
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return SoundCloudUserDefaultsHelper.getData(type: String.self, forKey: .scAccessToken)
    }
    
    private var refreshToken: String? {
        return SoundCloudUserDefaultsHelper.getData(type: String.self, forKey: .scAccessTokenExpiryDate)
    }

    private var tokenExpirationDate: Date? {
        return SoundCloudUserDefaultsHelper.getData(type: Date.self, forKey: .scUser)
    }
    
    
    
    public func signOut(completion: (Bool) -> Void) {
        UserDefaults.standard.setValue(nil, forKey: "scAccessToken")
        UserDefaults.standard.setValue(nil, forKey: "scAccessTokenExpiryDate")
        UserDefaults.standard.setValue(nil, forKey: "scUser")
        MainAuthManager.shared.soundCloudAuthenticationState = .unauthenticated
        MainAuthManager.shared.updateGeneralAuthState()
        completion(true)
    }

}
