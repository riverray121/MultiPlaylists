//
//  UserDefaultHelpers.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/10/23.
//

import Foundation


enum SoundCloudUserDefaultKeys: String, CaseIterable {
    case scAccessToken
    case scAccessTokenExpiryDate
    case scUser
}

enum SpotifyUserDefaultKeys: String, CaseIterable {
    case spfyAccessToken
    case spfyRefreshToken
    case spfyExpiresIn
}

final class SoundCloudUserDefaultsHelper {
    static func setData<T>(value: T, key: SoundCloudUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: SoundCloudUserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    static func removeData(key: SoundCloudUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}

final class SpotifyUserDefaultsHelper {
    static func setData<T>(value: T, key: SpotifyUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: SpotifyUserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    static func removeData(key: SpotifyUserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}
