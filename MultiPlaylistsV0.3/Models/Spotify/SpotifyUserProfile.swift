//
//  SpotifyUserProfile.swift
//  MultiPlaylistsV0.3
//
//  Created by Elijah Retzlaff on 1/21/23.
//

import Foundation

// MARK: - Empty
public struct SpotifyUserProfile: Codable {
    public let message: String?
//    public let playlists: Playlists?
    public let country: String?
    public let displayName: String?
    public let email: String?
//    public let explicitContent: ExplicitContent?
//    public let externalUrls: ExternalUrls?
//    public let followers: Followers?
    public let href: String?
    public let id: String
    public let images: [ImageModel]?
    public let product: String?
//    public let type: OwnerType?
    public let uri: String?
//    public let albums: Albums?
    public let tracks: [SpotifyTrack]?
//    public let seeds: [Seed]?

    enum CodingKeys: String, CodingKey {
        case message
//        case playlists
        case country
        case displayName = "display_name"
        case email
//        case explicitContent
//        case externalUrls
//        case followers
        case href
        case id
        case images
        case product
//        case type
        case uri
//        case albums
        case tracks
//        case seeds
    }

    public init(
        message: String?,
//        playlists: Playlists?,
        country: String?,
        displayName: String?,
        email: String?,
//        explicitContent: ExplicitContent?,
//        externalUrls: ExternalUrls?,
//        followers: Followers?,
        href: String?,
        id: String,
        images: [ImageModel]?,
        product: String?,
//        type: OwnerType?,
        uri: String?,
//        albums: Albums?,
        tracks: [SpotifyTrack]?
        //,
//        seeds: [Seed]?
    ) {
        self.message = message
//        self.playlists = playlists
        self.country = country
        self.displayName = displayName
        self.email = email
//        self.explicitContent = explicitContent
//        self.externalUrls = externalUrls
//        self.followers = followers
        self.href = href
        self.id = id
        self.images = images
        self.product = product
//        self.type = type
        self.uri = uri
//        self.albums = albums
        self.tracks = tracks
//        self.seeds = seeds
    }
}
